package com.springmvc.dto.common;

public class PageDTO {

    private int page;
    private int size;
    private int totalCount;
    private int totalPage;

    private int startPage;
    private int endPage;

    private boolean prev;
    private boolean next;

    public PageDTO() {
    }

    public PageDTO(int page, int size, int totalCount) {

        if (page < 1) {
            page = 1;
        }

        if (size < 1) {
            size = 10;
        }

        this.page = page;
        this.size = size;
        this.totalCount = totalCount;
        
        //meth.celi : 올림 함수
        this.totalPage = (int) Math.ceil((double) totalCount / size);

        if (this.totalPage == 0) {
            this.totalPage = 1;
        }

        int pageBlock = 10;

        this.endPage = (int) Math.ceil((double) page / pageBlock) * pageBlock;
        this.startPage = this.endPage - pageBlock + 1;

        if (this.endPage > this.totalPage) {
            this.endPage = this.totalPage;
        }

        if (this.startPage < 1) {
            this.startPage = 1;
        }

        this.prev = this.startPage > 1;
        this.next = this.endPage < this.totalPage;
    }

    public int getPage() {
        return page;
    }

    public int getSize() {
        return size;
    }

    public int getTotalCount() {
        return totalCount;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public int getStartPage() {
        return startPage;
    }

    public int getEndPage() {
        return endPage;
    }

    public boolean isPrev() {
        return prev;
    }

    public boolean isNext() {
        return next;
    }
}