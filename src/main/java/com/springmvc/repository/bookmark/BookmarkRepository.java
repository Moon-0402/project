package com.springmvc.repository.bookmark;

import java.util.List;

import com.springmvc.dto.bookmark.Bookmark;

public interface BookmarkRepository {

	// 즐겨찾기 목록 조회
    List<Bookmark> getBookmarkList(Long memberId);

    // 즐겨찾기 삭제
    void deleteBookmark(Long bookmarkId, Long memberId);
    
    // 즐겨찾기 추가
    void insertBookmark(Long memberId, Long restaurantId);
}
