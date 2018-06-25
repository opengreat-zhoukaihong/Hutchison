package net.line.fortress.apps.system.utils;

import java.util.*;


public class PageBrowser {

  private Iterator source = null;
  private List cacheList = new ArrayList();
  private int pageSize = 10;
  private int currentPageNum = 0;
  private List currentPageList = new ArrayList(pageSize);

  public PageBrowser(Iterator source) {
    this(source, 10);
  }
  public PageBrowser(Iterator source, int pageSize) {
    this.source = source;
    this.pageSize = pageSize;
    this.firstPage();
  }
  public void setSource(Iterator source) {
    this.source = source;
    firstPage();
  }
  public void setPageSize(int size) {
    this.pageSize = size;
    firstPage();
  }
  public int getCurrentPageNumber() {
    return this.currentPageNum;
  }
  public int getPageSize() {
    return this.pageSize;
  }
  public List getPage() {
    return this.currentPageList;
  }
  public boolean gotoPage(int pageNumber) {
    if (pageNumber < 1) {
      return false;
    } else {
      try {
        // test if the cache content this page
        this.getRow(((pageNumber - 1) * this.pageSize));
      } catch (IndexOutOfBoundsException e) {
        return false;
      }
      this.currentPageList.clear();
      this.currentPageNum = pageNumber;
      try {
        for (int i = (this.currentPageNum - 1) * this.pageSize; i < this.currentPageNum * this.pageSize; i++) {
          this.currentPageList.add(this.getRow(i));
        }
      } catch (IndexOutOfBoundsException e) {}
      return true;
    }
  }
  public boolean firstPage() {
    return this.gotoPage(1);
  }
  public boolean lastPage() {
    if (!this.isComplete()) {
      try {
        this.getRow(Integer.MAX_VALUE);
      } catch (IndexOutOfBoundsException e) {}
    }
    return this.gotoPage(((this.cacheList.size() - 1) / this.pageSize) + 1);
  }
  public boolean nextPage() {
    return this.gotoPage(this.currentPageNum + 1);
  }
  public boolean prevPage() {
    return this.gotoPage(this.currentPageNum - 1);
  }
  public void sort(Comparator c) {
    TreeSet ts = new TreeSet(c);
    try {
      for (int i = 0; true; i++) {
        ts.add(this.getRow(i));
      }
    } catch (IndexOutOfBoundsException e) {}
    this.cacheList = new ArrayList(ts);
  }
  private boolean isComplete() {
    return (this.source == null);
  }
  private Object getRow(int index) {
    if (index < this.cacheList.size()) {  //  in cache
      return cacheList.get(index);
    } else if (this.source != null) {  //  out of cache, fetch
      while (this.source.hasNext()) {
        this.cacheList.add(this.source.next());
        if (index < this.cacheList.size()) {
          return this.cacheList.get(index);
        }
      }
      this.source = null;
      throw new IndexOutOfBoundsException();
    } else {  //  fetching finished, out of range
      throw new IndexOutOfBoundsException();
    }
  }
}
