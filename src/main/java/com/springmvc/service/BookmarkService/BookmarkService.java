package com.springmvc.service.BookmarkService;

import java.util.List;

import com.springmvc.dto.bookmark.Bookmark;

public interface BookmarkService {

	List<Bookmark> getBookmarkList(Long memberId);
	
	void deleteBookmark(Long bookmarkId, Long memberId);
	
	void insertBookmark(Long memberId, Long restaurantId);
	
}
