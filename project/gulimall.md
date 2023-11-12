## 跨域

指的是浏览器不能执行其他网站的脚本。它是由浏览器的同源策略造成的，是**浏览器对javascript施加的安全限制**。

## 同源策略

是指协议，域名，端口都要相同，其中有一个不同都会产生跨域;

|                            URL                             |            **说明**            |              是否允许通信              |
| :--------------------------------------------------------: | :----------------------------: | :------------------------------------: |
|      http://www.a.com/a.js<br/>http://www.a.com/b.js       |           同一域名下           |                  允许                  |
| http://www.a.com/lab/a.js<br/>http://www.a.com/script/b.js |      同一域名下不同文件夹      |                  允许                  |
|    http://www.a.com:8000/a.js<br/>http://www.a.com/b.js    |       同一域名，不同端口       |                 不允许                 |
|      http://www.a.com/a.js<br/>https://www.a.com/b.js      |       同一域名，不同协议       |                 不允许                 |
|     http://www.a.com/a.js<br/>http://70.32.92.74/b.js      |        域名和域名对应ip        |                 不允许                 |
|     http://www.a.com/a.js<br/>http://script.a.com/b.js     |       主域相同，子域不同       |                 不允许                 |
|        http://www.a.com/a.js<br/>http://a.com/b.js         | 同一域名，不同二级域名（同上） | 不允许（cookie这种情况下也不允许访问） |
|   http://www.cnblogs.com/a.js<br/>http://www.a.com/b.js    |            不同域名            |                 不允许                 |

## 跨域流程

https://developer.mozilla.org/zh-CN/docs/Web/HTTP/CORS

## 解决跨域

1. 使用nginx部署为同一域
2. 配置当次请求允许跨域

```
1、添加响应头
• Access-Control-Allow-Origin:支持哪些来源的请求跨域
• Access-Control-Allow-Methods:支持哪些方法跨域
• Access-Control-Allow-Credentials:跨域请求默认不包含cookie，设置为true可以包含 cookie
• Access-Control-Expose-Headers:跨域请求暴露的字段
• CORS请求时，XMLHttpRequest对象的getResponseHeader()方法只能拿到6个基本字段: Cache-Control、Content-Language、Content-Type、Expires、Last-Modified、Pragma。如 果想拿到其他字段，就必须在Access-Control-Expose-Headers里面指定。
• Access-Control-Max-Age:表明该响应的有效时间为多少秒。在有效时间内，浏览器无 须为同一请求再次发起预检请求。请注意，浏览器自身维护了一个最大有效时间，如果 该首部字段的值超过了最大有效时间，将不会生效。
```

```java
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.reactive.CorsWebFilter;
import org.springframework.web.cors.reactive.UrlBasedCorsConfigurationSource;

@Configuration
public class GulimallCorsConfiguration {

    @Bean
    public CorsWebFilter corsWebFilter() {
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();

        CorsConfiguration corsConfiguration = new CorsConfiguration();

        //1、配置跨域
        corsConfiguration.addAllowedHeader("*");
        corsConfiguration.addAllowedMethod("*");
        corsConfiguration.addAllowedOrigin("*");
        corsConfiguration.setAllowCredentials(true);

        source.registerCorsConfiguration("/**",corsConfiguration);
        return new CorsWebFilter(source);
    }
}

```

## JSR303校验

```java
1. 先要在需要校验的字段上加上注解
	@NotBlank
	private String name;
2. 开启校验
 	  @RequestMapping("/save")
    public R save(@Valid @RequestBody BrandEntity brand){
		brandService.save(brand);

        return R.ok();
    }



3.自定义返回错误数据
  @NotBlank(message = "品牌名不可以为空")
	private String name;
	@URL(message = "logo必须是一个合法的url地址")
	private String logo;
	@Pattern(regexp = "/^[a-zA-Z]$/" , message = "检索首字母必须是一个字母 ")
	private String firstLetter;

		@RequestMapping("/save")
    public R save(@Valid @RequestBody BrandEntity brand, BindingResult result) {
        // BindingResult是绑定效验的结果  并返回我们想要的样式
        if (result.hasErrors()) {
            Map<String, String> map = new HashMap<>();
            //  1. 获取效验的错误结果
            result.getFieldErrors().forEach((fieldError -> {
                // fieldError 获取到错误提示
                String message = fieldError.getDefaultMessage();
                // 获取到错误的字段的名字
                String field = fieldError.getField();
                map.put(field, message);
            }));

            return R.error(400,"提交数据不合法").put("data", map);

        } else {
            brandService.save(brand);
        }
        return R.ok();
    }


```

## 统一的异常处理

```java
@ControllerAdvice+@ExceptionHandler
系统错误码
/***
* 错误码和错误信息定义类
* 1. 错误码定义规则为 5 为数字
* 2. 前两位表示业务场景，最后三位表示错误码。例如:100001。10:通用 001:系统未知
异常
* 3. 维护错误码后需要维护错误描述，将他们定义为枚举形式
* * * * * * * * * */
错误码列表: 10:通用
001:参数格式校验 11:商品
12:订单 13: 购物车 14:物流
  
```

代码实例

```java
public enum SystemStatusCode {

    UNKNOWN_EXCEPTION(10000, "系统未知异常"),
    VALID_EXCEPTION(10001, "参数效验格式失败");

    private int code;
    private String msg;

    SystemStatusCode(int code, String msg){
        this.code = code;
        this.msg = msg;
    }

    public int getCode() {
        return code;
    }

    public String getMsg() {
        return msg;
    }
}

```



```java
package com.zhoushuiping.gulimall.product.exception;

import com.zhoushuiping.common.exception.SystemStatusCode;
import com.zhoushuiping.common.utils.R;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.HashMap;
import java.util.Map;

// 集中处理所有异常
@Slf4j
//@ResponseBody
//@ControllerAdvice(basePackages = "com.zhoushuiping.gulimall.product.controller") // 标柱处理那些类的异常
@RestControllerAdvice(basePackages = "com.zhoushuiping.gulimall.product.controller")
public class GulimallExceptionControllerAdvice {


    @ExceptionHandler(value = MethodArgumentNotValidException.class)
    public R handlerValidException(MethodArgumentNotValidException e){

        log.error("数据效验出现问题 {} , 异常类型 {}", e.getMessage(), e.getClass());

        BindingResult bindingResult = e.getBindingResult();

        Map<String, String> errorMap = new HashMap<>();
        bindingResult.getFieldErrors().forEach(fieldError -> {
            errorMap.put(fieldError.getField(), fieldError.getDefaultMessage());
        });
        return R.error(SystemStatusCode.VALID_EXCEPTION.getCode(), SystemStatusCode.VALID_EXCEPTION.getMsg()).put("data",errorMap);
    }

    @ExceptionHandler(value = Throwable.class)
    public R handlerException(Throwable e){

        return R.error(SystemStatusCode.UNKNOWN_EXCEPTION.getCode(),SystemStatusCode.UNKNOWN_EXCEPTION.getMsg());
    }
}

```

## 分组校验

```java
public interface AddGroup {
}

public interface UpdateGroup {
}
```

```java
@NotNull(message = "修改必须指定品牌id", groups = {UpdateGroup.class})
@Null(message = "新增不能指定品牌id", groups = {AddGroup.class})
@TableId
private Long brandId;
@NotBlank(message = "品牌名不可以为空", groups = {UpdateGroup.class, AddGroup.class})
private String name;
```

 ```java
 @RequestMapping("/save")
 public R save(@Validated(value = {AddGroup.class}) @RequestBody BrandEntity brand){
 
         return R.ok();
 }
 ```

##  自定义效验

1. 编写一个自定义的校验注解

```java
ValidationMessages.properties
com.zhoushuiping.common.valid.ListValue.message=必须提交指定的值0,1

  
@Constraint(validatedBy = {LIstValueConstraintValidator.class})
@Target({ElementType.METHOD, ElementType.FIELD, ElementType.ANNOTATION_TYPE, ElementType.CONSTRUCTOR, ElementType.PARAMETER, ElementType.TYPE_USE})
@Retention(RetentionPolicy.RUNTIME)
public @interface ListValue {

    String message() default "{com.zhoushuiping.common.valid.ListValue.message}";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

    int[] vals ()default {};
}
```

2. 编写一个自定义校验器

```java
import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import java.util.HashSet;
import java.util.Set;

public class LIstValueConstraintValidator implements ConstraintValidator<ListValue,Integer> {

    private Set<Integer> set = new HashSet<>();

    // 判断是否校验成功
    @Override
    public boolean isValid(Integer integer, ConstraintValidatorContext constraintValidatorContext) {
        return set.contains(integer);
    }

    // 初始化方法
    @Override
    public void initialize(ListValue constraintAnnotation) {

        int []vals = constraintAnnotation.vals();
        for (int i : vals)
            set.add(i);
    }
}
```

3. 关联自定义校验器和自定义的校验注解

## SPU和SKU

**SPU**:**Standard Product Unit**(标准化产品单元) 是商品信息聚合的最小单位，是一组可复用、易检索的标准化信息的集合，该集合描述了一 个产品的特性。

IphoneX 是 SPU 

MI 8 是 SPU 

IphoneX 64G 黑曜石 是 SKU 

MI8 8+64G+黑色 是 SKU

**SKU**:**Stock Keeping Unit**(库存量单位) 即库存进出计量的基本单元，可以是以件，盒，托盘等为单位。SKU 这是对于大型连锁超市 DC(配送中心)物流管理的一个必要的方法。现在已经被引申为产品统一编号的简称，每 种产品均对应有唯一的 SKU 号。

## 基本属性【规格参数】与销售属性

每个分类下的商品共享规格参数，与销售属性。只是有些商品不一定要用这个分类下全部的

属性;

* 属性是以三级分类组织起来的
*  规格参数中有些是可以提供检索的
*   规格参数也是基本属性，他们具有自己的分组
*   属性的分组也是以三级分类组织起来的
*   属性名确定的，但是值是每一个商品不同来决定的

## **Object** 划分

**1. PO(persistant object)** 持久对象

PO 就是对应数据库中某个表中的一条记录，多个记录可以用 PO 的集合。 PO 中应该不包 含任何对数据库的操作。

**2. DO**(**Domain Object**)

领域对象  就是从现实世界中抽象出来的有形或无形的业务实体。

**3. TO(Transfer Object)** 

  数据传输对象  不同的应用程序之间传输的对象

**4.DTO**(**Data Transfer Object**)数据传输对象

  这个概念来源于 J2EE 的设计模式，原来的目的是为了 EJB 的分布式应用提供粗粒度的 数据实体，以减少分布式调用的次数，从而提高分布式调用的性能和降低网络负载，但在这 里，泛指用于展示层与服务层之间的数据传输对象。

**5.VO(value object)** 值对象

  通常用于业务层之间的数据传递，和 PO 一样也是仅仅包含数据而已。但应是抽象出 的业务对象 , 可以和表对应 , 也可以不 , 这根据业务的需要 。用 new 关键字创建，由 GC 回收的。
 View object:视图对象;

```
接受页面传递来的数据，封装对象
将业务处理完成的对象，封装成页面要用的数据
```

**6.BO(business object)** 业务对象

  从业务模型的角度看 , 见 UML 元件领域模型中的领域对象。封装业务逻辑的 java 对 象 , 通过调用 DAO 方法 , 结合 PO,VO 进行业务操作。 business object: 业务对象 主要作 用是把业务逻辑封装为一个对象。这个对象可以包括一个或多个其它的对象。 比如一个简 历，有教育经历、工作经历、社会关系等等。 我们可以把教育经历对应一个 PO ，工作经 历对应一个 PO ，社会关系对应一个 PO 。 建立一个对应简历的 BO 对象处理简历，每 个 BO 包含这些 PO 。 这样处理业务逻辑时，我们就可以针对 BO 去处理。

**7.POJO(plain ordinary java object)** 简单无规则 **java** 对象

  传统意义的 java 对象。就是说在一些 Object/Relation Mapping 工具中，能够做到维护 数据库表记录的 persisent object 完全是一个符合 Java Bean 规范的纯 Java 对象，没有增 加别的属性和方法。我的理解就是最基本的 java Bean ，只有属性字段及 setter 和 getter 方法!。

POJO 是 DO/DTO/BO/VO 的统称。
 **8.DAO(data access object)** 数据访问对象

  是一个 sun 的一个标准 j2ee 设计模式， 这个模式中有个接口就是 DAO ，它负持久 层的操作。为业务层提供接口。此对象用于访问数据库。通常和 PO 结合使用， DAO 中包 含了各种数据库的操作方法。通过它的方法 , 结合 PO 对数据库进行相关的操作。夹在业 务逻辑与数据库资源中间。配合 VO, 提供数据库的 CRUD 操作.
