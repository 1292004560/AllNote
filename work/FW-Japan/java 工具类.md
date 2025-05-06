## AWS S3 上传工具类

```java
package com.gs.utils;

import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.net.URI;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.UUID;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.stream.Collectors;

public class AwsS3FileUploader {
    private static final Logger logger = LoggerFactory.getLogger(AwsS3FileUploader.class);

    private final String region;
    private final String accessKeyId;
    private final String secretAccessKey;
    private final String bucketName;
    private final String fileHost;
    private final String baseDir;
    private final ExecutorService executorService;
    private final S3Client s3Client;

    public AwsS3FileUploader(String region, String accessKeyId, String secretAccessKey,
                             String bucketName, String fileHost, String baseDir) {
        this.region = region;
        this.accessKeyId = accessKeyId;
        this.secretAccessKey = secretAccessKey;
        this.bucketName = bucketName;
        this.fileHost = fileHost;
        this.baseDir = baseDir;
        this.executorService = Executors.newCachedThreadPool();

        AwsBasicCredentials awsCreds = AwsBasicCredentials.create(accessKeyId, secretAccessKey);
        this.s3Client = S3Client.builder()
                .region(Region.of(region))
                .credentialsProvider(StaticCredentialsProvider.create(awsCreds))
                .build();
//        this.s3Client = S3Client.builder()
//                .region(Region.of(region))
//                .endpointOverride(URI.create(fileHost))
//                .credentialsProvider(StaticCredentialsProvider.create(awsCreds))
//                .build();

    }

    /**
     * 异步上传MultipartFile文件到S3
     */
    public CompletableFuture<String> uploadFileAsync(MultipartFile file, String dirPath) {
        return CompletableFuture.supplyAsync(() -> {
            try {
                return uploadFile(file, dirPath);
            } catch (AwsS3UploadException e) {
                throw new RuntimeException(e);
            }
        }, executorService);
    }

    /**
     * 上传MultipartFile文件到S3
     */
    public String uploadFile(MultipartFile file, String dirPath) throws AwsS3UploadException {
        validateFile(file);
        try (InputStream inputStream = file.getInputStream()) {
            return uploadFile(inputStream, dirPath, file.getOriginalFilename());
        } catch (IOException e) {
            logger.error("文件流读取失败：{}", e.getMessage());
            throw new AwsS3UploadException("文件读取失败", e);
        }
    }

    /**
     * 上传InputStream文件到S3
     */
    public String uploadFile(InputStream inputStream, String dirPath, String fileName) throws AwsS3UploadException {
        if (inputStream == null) {
            logger.error("文件流为空");
            throw new AwsS3UploadException("文件流不能为空");
        }
        String objectName = buildObjectName(dirPath, generateUniqueFileName(fileName));
        try {
            PutObjectRequest putObjectRequest = PutObjectRequest.builder()
                    .bucket(bucketName)
                    .key(objectName)
                    .build();
            s3Client.putObject(putObjectRequest, RequestBody.fromInputStream(inputStream, inputStream.available()));
            logger.info("文件上传成功，URL：{}", getFileUrl(objectName));
            return getFileUrl(objectName);
        } catch (Exception e) {
            logger.error("S3上传失败：{}", e.getMessage());
            throw new AwsS3UploadException("文件上传失败", e);
        }
    }

    /**
     * 删除S3上的文件
     */
    public void deleteFile(String fileUrl) throws AwsS3UploadException {
        if (fileUrl == null || !fileUrl.startsWith(fileHost)) {
            logger.error("文件URL无效");
            throw new AwsS3UploadException("文件URL无效");
        }
        String objectName = fileUrl.substring(fileHost.length() + 1);
        try {
            DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder()
                    .bucket(bucketName)
                    .key(objectName)
                    .build();
            s3Client.deleteObject(deleteObjectRequest);
            logger.info("文件删除成功：{}", fileUrl);
        } catch (Exception e) {
            logger.error("文件删除失败：{}", e.getMessage());
            throw new AwsS3UploadException("文件删除失败", e);
        }
    }

    /**
     * 批量删除S3上的文件
     */
    public void deleteFiles(List<String> fileUrls) throws AwsS3UploadException {
        if (fileUrls == null || fileUrls.isEmpty()) {
            logger.error("文件URL列表为空");
            throw new AwsS3UploadException("文件URL列表不能为空");
        }
        List<String> objectNames = fileUrls.stream()
                .filter(url -> url != null && url.startsWith(fileHost))
                .map(url -> url.substring(fileHost.length() + 1))
                .collect(Collectors.toList());
        try {
            List<ObjectIdentifier> objectIdentifiers = objectNames.stream()
                    .map(name -> ObjectIdentifier.builder().key(name).build())
                    .collect(Collectors.toList());
            Delete delete = Delete.builder().objects(objectIdentifiers).build();
            DeleteObjectsRequest deleteObjectsRequest = DeleteObjectsRequest.builder()
                    .bucket(bucketName)
                    .delete(delete)
                    .build();
            s3Client.deleteObjects(deleteObjectsRequest);
            logger.info("批量删除文件成功：{}", fileUrls);
        } catch (Exception e) {
            logger.error("批量删除文件失败：{}", e.getMessage());
            throw new AwsS3UploadException("批量删除文件失败", e);
        }
    }

    /**
     * 校验文件是否有效
     */
    private void validateFile(MultipartFile file) throws AwsS3UploadException {
        if (file == null || file.isEmpty()) {
            logger.error("上传文件为空");
            throw new AwsS3UploadException("文件不能为空");
        }
        if (file.getOriginalFilename() == null || file.getOriginalFilename().isEmpty()) {
            logger.error("文件名无效");
            throw new AwsS3UploadException("文件名无效");
        }
    }

    /**
     * 生成唯一的文件名
     */
    private String generateUniqueFileName(String originalName) {
        String extension = originalName.substring(originalName.lastIndexOf("."));
        return UUID.randomUUID().toString() + extension;
    }

    /**
     * 构建S3存储路径
     */
    private String buildObjectName(String dirPath, String fileName) {
        dirPath = dirPath.replaceAll("//", "/");
        if (!dirPath.startsWith("/")) dirPath = "/" + dirPath;
        return baseDir + dirPath + "/" + fileName;
    }

    /**
     * 获取文件访问URL
     */
    private String getFileUrl(String objectName) {
        return fileHost + "/" + objectName;
    }

    /**
     * 关闭S3Client和ExecutorService
     */
    public void shutdown() {
        if (s3Client != null) {
            s3Client.close();
            logger.info("S3Client已关闭");
        }
        if (executorService != null) {
            executorService.shutdown();
            logger.info("ExecutorService已关闭");
        }
    }


    /**
     * 异步分片上传大文件
     * @param file 上传文件
     * @param dirPath 存储目录
     * @param partSizeMB 分片大小(MB)，默认5MB
     */
    public CompletableFuture<String> uploadLargeFileAsync(MultipartFile file,
                                                          String dirPath,
                                                          int partSizeMB) {
        return CompletableFuture.supplyAsync(() -> {
            try {
                return uploadLargeFile(file, dirPath, partSizeMB);
            } catch (AwsS3UploadException e) {
                throw new RuntimeException(e);
            }
        }, executorService);
    }

    public String uploadLargeFile(MultipartFile file,
                                  String dirPath,
                                  int partSizeMB) throws AwsS3UploadException {
        validateFile(file);
        final int partSize = partSizeMB * 1024 * 1024;
        String objectName = buildObjectName(dirPath, generateUniqueFileName(file.getOriginalFilename()));
        String uploadId = null; // 在这里声明uploadId

        try (InputStream inputStream = file.getInputStream()) {
            // 1. 初始化分片上传
            uploadId = initiateMultipartUpload(objectName); // 这里赋值

            // 2. 上传所有分片
            List<CompletedPart> completedParts = uploadParts(inputStream, objectName, uploadId, partSize);

            // 3. 完成上传
            return completeMultipartUpload(objectName, uploadId, completedParts);
        } catch (Exception e) {
            if (uploadId != null) { // 添加空值检查
                abortMultipartUpload(objectName, uploadId);
            }
            logger.error("分片上传失败：{}", e.getMessage());
            throw new AwsS3UploadException("分片上传失败", e);
        }
    }

    // 初始化分片上传
    private String initiateMultipartUpload(String objectName) {
        CreateMultipartUploadRequest createRequest = CreateMultipartUploadRequest.builder()
                .bucket(bucketName)
                .key(objectName)
                .build();

        CreateMultipartUploadResponse response = s3Client.createMultipartUpload(createRequest);
        return response.uploadId();
    }

    // 上传分片
    private List<CompletedPart> uploadParts(InputStream inputStream,
                                            String objectName,
                                            String uploadId,
                                            int partSize) throws IOException {
        List<CompletedPart> completedParts = new ArrayList<>();
        byte[] buffer = new byte[partSize];
        int partNumber = 1;
        int bytesRead;

        while ((bytesRead = inputStream.read(buffer)) > 0) {
            // 最后一个分片可能小于partSize
            byte[] actualBytes = new byte[bytesRead];
            System.arraycopy(buffer, 0, actualBytes, 0, bytesRead);

            UploadPartRequest uploadRequest = UploadPartRequest.builder()
                    .bucket(bucketName)
                    .key(objectName)
                    .uploadId(uploadId)
                    .partNumber(partNumber)
                    .build();

            UploadPartResponse uploadResponse = s3Client.uploadPart(
                    uploadRequest,
                    RequestBody.fromBytes(actualBytes)
            );

            completedParts.add(CompletedPart.builder()
                    .partNumber(partNumber)
                    .eTag(uploadResponse.eTag())
                    .build());

            partNumber++;
        }

        return completedParts;
    }

    // 完成分片上传
    private String completeMultipartUpload(String objectName,
                                           String uploadId,
                                           List<CompletedPart> completedParts) {
        // 按分片号排序
        completedParts.sort(Comparator.comparingInt(CompletedPart::partNumber));

        CompletedMultipartUpload completedUpload = CompletedMultipartUpload.builder()
                .parts(completedParts)
                .build();

        CompleteMultipartUploadRequest completeRequest = CompleteMultipartUploadRequest.builder()
                .bucket(bucketName)
                .key(objectName)
                .uploadId(uploadId)
                .multipartUpload(completedUpload)
                .build();

        s3Client.completeMultipartUpload(completeRequest);
        return getFileUrl(objectName);
    }

    // 中止分片上传
    private void abortMultipartUpload(String objectName, String uploadId) {
        if (uploadId == null) return;

        AbortMultipartUploadRequest abortRequest = AbortMultipartUploadRequest.builder()
                .bucket(bucketName)
                .key(objectName)
                .uploadId(uploadId)
                .build();

        s3Client.abortMultipartUpload(abortRequest);
    }

    /**
     * 自定义文件上传异常
     */
    public static class AwsS3UploadException extends Exception {
        public AwsS3UploadException(String message) {
            super(message);
        }

        public AwsS3UploadException(String message, Throwable cause) {
            super(message, cause);
        }
    }
}   
```

```java
package com.gs.config;

import com.gs.utils.AwsS3FileUploader;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AwsS3Config {

    @Value("${aws.s3.region}")
    private String region;

    @Value("${aws.s3.accessKeyId}")
    private String accessKeyId;

    @Value("${aws.s3.secretAccessKey}")
    private String secretAccessKey;

    @Value("${aws.s3.bucketName}")
    private String bucketName;

    @Value("${aws.s3.fileHost}")
    private String fileHost;

    @Value("${aws.s3.baseDir}")
    private String baseDir;

    @Bean
    public AwsS3FileUploader awsS3FileUploader() {
        return new AwsS3FileUploader(region, accessKeyId, secretAccessKey, bucketName, fileHost, baseDir);
    }
}
```

```yaml
aws:
  s3:
    region: **
    accessKeyId: ******
    secretAccessKey: ******
    bucketName: cardshop-data-dev
    baseDir: uploads
    fileHost: https://cardshop-data-dev.s3.ap-northeast-1.amazonaws.com
```

## OSS 上传工具类

```java
import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import com.aliyun.oss.model.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.stream.Collectors;

public class OssFileUploader {
    private static final Logger logger = LoggerFactory.getLogger(OssFileUploader.class);

    private final String endpoint;
    private final String accessKeyId;
    private final String accessKeySecret;
    private final String bucketName;
    private final String fileHost;
    private final String baseDir; // 文件存储基础目录
    private final ExecutorService executorService; // 线程池管理异步任务
    private final OSS ossClient; // 单例OSSClient

    public OssFileUploader(String endpoint, String accessKeyId, String accessKeySecret,
                          String bucketName, String fileHost, String baseDir) {
        this.endpoint = endpoint;
        this.accessKeyId = accessKeyId;
        this.accessKeySecret = accessKeySecret;
        this.bucketName = bucketName;
        this.fileHost = fileHost;
        this.baseDir = baseDir.endsWith("/") ? baseDir : baseDir + "/";
        this.executorService = Executors.newCachedThreadPool(); // 初始化线程池
        this.ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret); // 单例OSSClient
    }

    /**
     * 上传MultipartFile文件到OSS（异步）
     *
     * @param file    上传的文件对象
     * @param dirPath 存储目录路径（相对于baseDir）
     * @return 文件访问URL的CompletableFuture
     */
    public CompletableFuture<String> uploadFileAsync(MultipartFile file, String dirPath) {
        return CompletableFuture.supplyAsync(() -> {
            try {
                return uploadFile(file, dirPath);
            } catch (OssUploadException e) {
                throw new RuntimeException(e);
            }
        }, executorService);
    }

    /**
     * 上传MultipartFile文件到OSS
     *
     * @param file    上传的文件对象
     * @param dirPath 存储目录路径（相对于baseDir）
     * @return 文件访问URL
     * @throws OssUploadException 文件上传异常
     */
    public String uploadFile(MultipartFile file, String dirPath) throws OssUploadException {
        validateFile(file);
        try (InputStream inputStream = file.getInputStream()) {
            return uploadFile(inputStream, dirPath, file.getOriginalFilename());
        } catch (IOException e) {
            logger.error("文件流读取失败：{}", e.getMessage());
            throw new OssUploadException("文件读取失败", e);
        }
    }

    /**
     * 上传InputStream文件到OSS
     *
     * @param inputStream 文件输入流
     * @param dirPath     存储目录路径（相对于baseDir）
     * @param fileName    文件名
     * @return 文件访问URL
     * @throws OssUploadException 文件上传异常
     */
    public String uploadFile(InputStream inputStream, String dirPath, String fileName) throws OssUploadException {
        if (inputStream == null) {
            logger.error("文件流为空");
            throw new OssUploadException("文件流不能为空");
        }
        String objectName = buildObjectName(dirPath, generateUniqueFileName(fileName));
        try {
            PutObjectRequest request = new PutObjectRequest(bucketName, objectName, inputStream);
            request.setProcess("true"); // 开启图片处理
            request.setProgressListener((bytesWritten, totalBytes) ->
                    logger.debug("上传进度：{:.1f}%", (double) bytesWritten / totalBytes * 100));

            PutObjectResult result = ossClient.putObject(request);
            logger.info("文件上传成功，URL：{}", getFileUrl(objectName));
            return getFileUrl(objectName);
        } catch (Exception e) {
            logger.error("OSS上传失败：{}", e.getMessage());
            throw new OssUploadException("文件上传失败", e);
        }
    }

    /**
     * 删除OSS上的文件
     *
     * @param fileUrl 文件访问URL
     * @throws OssUploadException 文件删除异常
     */
    public void deleteFile(String fileUrl) throws OssUploadException {
        if (fileUrl == null || !fileUrl.startsWith(fileHost)) {
            logger.error("文件URL无效");
            throw new OssUploadException("文件URL无效");
        }
        String objectName = fileUrl.substring(fileHost.length() + 1);
        try {
            ossClient.deleteObject(bucketName, objectName);
            logger.info("文件删除成功：{}", fileUrl);
        } catch (Exception e) {
            logger.error("文件删除失败：{}", e.getMessage());
            throw new OssUploadException("文件删除失败", e);
        }
    }

    /**
     * 批量删除OSS上的文件
     *
     * @param fileUrls 文件访问URL列表
     * @throws OssUploadException 文件删除异常
     */
    public void deleteFiles(List<String> fileUrls) throws OssUploadException {
        if (fileUrls == null || fileUrls.isEmpty()) {
            logger.error("文件URL列表为空");
            throw new OssUploadException("文件URL列表不能为空");
        }
        List<String> objectNames = fileUrls.stream()
                .filter(url -> url != null && url.startsWith(fileHost))
                .map(url -> url.substring(fileHost.length() + 1))
                .collect(Collectors.toList());
        try {
            DeleteObjectsRequest request = new DeleteObjectsRequest(bucketName).withKeys(objectNames);
            ossClient.deleteObjects(request);
            logger.info("批量删除文件成功：{}", fileUrls);
        } catch (Exception e) {
            logger.error("批量删除文件失败：{}", e.getMessage());
            throw new OssUploadException("批量删除文件失败", e);
        }
    }

    /**
     * 校验文件是否有效
     */
    private void validateFile(MultipartFile file) throws OssUploadException {
        if (file == null || file.isEmpty()) {
            logger.error("上传文件为空");
            throw new OssUploadException("文件不能为空");
        }
        if (file.getOriginalFilename() == null || file.getOriginalFilename().isEmpty()) {
            logger.error("文件名无效");
            throw new OssUploadException("文件名无效");
        }
    }

    /**
     * 生成唯一的文件名
     */
    private String generateUniqueFileName(String originalName) {
        String extension = originalName.substring(originalName.lastIndexOf("."));
        return UUID.randomUUID().toString() + extension;
    }

    /**
     * 构建OSS存储路径
     */
    private String buildObjectName(String dirPath, String fileName) {
        dirPath = dirPath.replaceAll("//", "/");
        if (!dirPath.startsWith("/")) dirPath = "/" + dirPath;
        return baseDir + dirPath + "/" + fileName;
    }

    /**
     * 获取文件访问URL
     */
    private String getFileUrl(String objectName) {
        return fileHost + "/" + objectName;
    }

    /**
     * 关闭OSSClient和ExecutorService
     */
    public void shutdown() {
        if (ossClient != null) {
            ossClient.shutdown();
            logger.info("OSSClient已关闭");
        }
        if (executorService != null) {
            executorService.shutdown();
            logger.info("ExecutorService已关闭");
        }
    }

    /**
     * 自定义文件上传异常
     */
    public static class OssUploadException extends Exception {
        public OssUploadException(String message) {
            super(message);
        }

        public OssUploadException(String message, Throwable cause) {
            super(message, cause);
        }
    }
}
```

```java


import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class OssConfig {

    @Value("${aliyun.oss.endpoint}")
    private String endpoint;

    @Value("${aliyun.oss.accessKeyId}")
    private String accessKeyId;

    @Value("${aliyun.oss.accessKeySecret}")
    private String accessKeySecret;

    @Value("${aliyun.oss.bucketName}")
    private String bucketName;

    @Value("${aliyun.oss.fileHost}")
    private String fileHost;

    @Value("${aliyun.oss.baseDir}")
    private String baseDir;

    @Bean
    public OssFileUploader ossFileUploader() {
        return new OssFileUploader(endpoint, accessKeyId, accessKeySecret, bucketName, fileHost, baseDir);
    }
}
```

```properties
aliyun.oss.endpoint=your-oss-endpoint
aliyun.oss.accessKeyId=your-access-key-id
aliyun.oss.accessKeySecret=your-access-key-secret
aliyun.oss.bucketName=your-bucket-name
aliyun.oss.fileHost=your-file-host
aliyun.oss.baseDir=your-base-dir
```

