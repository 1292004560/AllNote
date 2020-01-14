### 优先队列

#### 基于顺序动态数组的实现

```java
public interface Queue<E> {


    boolean isEmpty();


    int getSize();

    E peek();


    E dequeue();


    void enqueue(E e);

}

import java.util.ArrayList;

public class PriorityQueue<E extends Comparable<E>> implements Queue<E> {


    private ArrayList<E> arrayList;

    public PriorityQueue(int capacity) {
        arrayList = new ArrayList<>(capacity);
    }


    public PriorityQueue() {

         arrayList = new ArrayList<>();
    }

    @Override
    public boolean isEmpty() {
        return arrayList.isEmpty();
    }

    @Override
    public int getSize() {
        return arrayList.size();
    }

    @Override
    public E peek() {

        return arrayList.get(0);
    }

    @Override
    public E dequeue() {
        return arrayList.remove(getSize()-1);
    }

    @Override
    public void enqueue(E e) {


        if (isEmpty()) {
            arrayList.add(e);
        } else if (e.compareTo(arrayList.get(0)) < 0) {
            arrayList.add(0, e);
        } else if (e.compareTo(arrayList.get(getSize() - 1)) > 0) {
            arrayList.add(getSize(), e);
        }

        for (int i = 0; i < getSize() - 1; i++) {
            if (e.compareTo(arrayList.get(i)) > 0 && e.compareTo(arrayList.get(i + 1)) < 0) {
                arrayList.add(i + 1, e);
            }
        }
    }
}
```

#### 基于普通动态数组实现

```java
public interface Queue<E> {


    boolean isEmpty();


    int getSize();

    E peek();


    E dequeue();


    void enqueue(E e);

}

import java.util.ArrayList;

public class PriorityQueue2<E extends Comparable<E>> implements Queue<E> {

    private ArrayList<E> arrayList;


    public PriorityQueue2(int capacity){

        arrayList = new ArrayList<>(capacity);
    }

    public PriorityQueue2(){

        arrayList = new ArrayList<>();
    }

    @Override
    public boolean isEmpty() {

        return arrayList.isEmpty();

    }

    @Override
    public int getSize() {
       return arrayList.size();
    }

    @Override
    public E peek() {
        return arrayList.get(0);
    }
    @Override
    public E dequeue() {

        if (isEmpty()){
            throw new IllegalArgumentException("Queue is empty,don't dequeue");
        }
        E maxElement = arrayList.get(0);
        int maxIndex = 0;
        for(int i = 1;i < getSize();i++){
            if (maxElement.compareTo(arrayList.get(i))<0){
                maxElement = arrayList.get(i);
                maxIndex = i;
            }
        }

        arrayList.remove(maxIndex);
        return  maxElement;
    }

    @Override
    public void enqueue(E e) {

        arrayList.add(e);
    }


}


```

#### 二叉堆的实现

```java
import java.util.ArrayList;
import java.util.Collections;

public class MaxHeap<E extends Comparable<E>>{

    private ArrayList<E> arrayList;


    public MaxHeap(int capacity){

        arrayList = new ArrayList<>(capacity);
    }

    public MaxHeap(){
        this(10);
    }


    public MaxHeap(E [] array){

        arrayList = new ArrayList<>(arrayList);

        int i = parentIndex(getSize() - 1);
        for (;i >= 0;i--){
            shiftDown(i);
        }


    }

    public boolean isEmpty(){

        return arrayList.isEmpty();
    }

    public int getSize(){

        return  arrayList.size();
    }



    //根据子节点的索引获取父节点的索引
    private int parentIndex(int index){

        if (index == 0)
            throw new IllegalArgumentException("index - 0 don't have parent index");
        return (index - 1)/2;
    }

    //根据父节点获取左孩子的索引
    private int leftChildIndex(int index){

        return index * 2 + 1;
    }

    //根据父节点的索引获取右孩子的索引
    private int rightChildIndex(int index){

        return index * 2 + 2;
    }

    //向堆中添加元素
    public void add(E e){
        arrayList.add(getSize(),e);
        shiftUp(arrayList.size() - 1);
    }

    private void shiftUp(int index){

        while (index > 0 && 					arrayList.get(parentIndex(index)).compareTo(arrayList.get(index))< 0){


            swap(index,parentIndex(index));

            index = parentIndex(index);

        }
    }
    //看堆顶的元素
    public E getFront(){

        return arrayList.get(0);
    }
    //取出堆顶的元素
    public E extract(){

       E result = getFront();

       swap(0,getSize()-1);
       arrayList.remove(getSize()-1);
       shiftDown(0);

       return result;

    }

    private void shiftDown(int index){

        while (leftChildIndex( index ) < getSize()){

            int j = leftChildIndex(index);
            if (j + 1 < getSize() && arrayList.get(j).compareTo(arrayList.get(j+1)) < 0){
                //此时的根节点有右孩子
                j = rightChildIndex(index);
            }

            if (arrayList.get(index).compareTo(arrayList.get(j)) >= 0)
                break;

            swap(j,index);

            index = j ;
        }

    }

    public E replace(E e){
        E result = getFront();
        arrayList.set(0,e);
        shiftDown(0);
        return result;
    }

    private void swap(int a,int b){
        if ( a < 0 || b < 0 || a >= getSize() || b >= getSize())
            throw new IllegalArgumentException("Index is illegal");
        Collections.swap(arrayList,a,b);
    }
}

```

#### 三叉堆的实现

```java
import java.util.ArrayList;
import java.util.Collections;

public class Heap<E extends Comparable<E>> {

    private ArrayList<E> arrayList;

    public Heap(int capacity) {
        arrayList = new ArrayList<>(capacity);
    }

    public Heap() {

        arrayList = new ArrayList<>();
    }


    public boolean isEmpty() {

        return arrayList.isEmpty();
    }

    public int getSize() {

        return arrayList.size();
    }

    private int parentIndex(int index) {

        if (index <= 0)
            throw new IllegalArgumentException("0-index don't parent index");
        return (index - 1) / 3;

    }

    private int leftIndex(int index) {

        return index * 3 + 1;
    }

    private int middleIndex(int index) {
        return index * 3 + 2;
    }

    private int rightIndex(int index) {

        return index * 3 + 3;
    }

    public void add(E e) {

        arrayList.add(getSize(), e);
        shiftUp(arrayList.size() - 1);
    }

    private void shiftUp(int index) {

        while (index > 0 && arrayList.get(index).compareTo(arrayList.get(parentIndex(index))) > 0) {
            Collections.swap(arrayList, index, parentIndex(index));
            index = parentIndex(index);
        }

    }

    public E extractMax() {
        E result = arrayList.get(0);

        Collections.swap(arrayList, 0, getSize() - 1);//第一个跟最后一个交换
        arrayList.remove(getSize()-1);
        shiftDown(0);

        return result;
    }

    private void shiftDown(int index) {

        while (leftIndex(index) < getSize()) {
            int k = max(index);

            if (arrayList.get(index).compareTo(arrayList.get(k)) >= 0)
                break;

            Collections.swap(arrayList,k,index);
            index = k;
        }

    }

    private int max(int index) {

        E maxElement = arrayList.get(index);

        int resultIndex = index;

        for (int i = leftIndex(index); i <= rightIndex(index) && i < getSize(); i++) {
            if (maxElement.compareTo(arrayList.get(i)) < 0) {
                maxElement = arrayList.get(i);
                resultIndex = i;
            }
        }

        return resultIndex;

    }
}

```

### 线段树(segment tree)

**基于区间的统计查询**

![segmentTree](E:\workSpace\AllNote\imges\segmentTree.png)

**线段树不是完全二叉树但是是一个平衡二叉树**

**平衡二叉树定义是最大深度与最小深度相差小于或等于1**

![](E:\workSpace\AllNote\imges\segmentTree02.png)

