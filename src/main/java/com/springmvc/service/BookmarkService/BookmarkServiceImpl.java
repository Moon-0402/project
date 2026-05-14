package com.springmvc.service.BookmarkService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springmvc.dto.bookmark.Bookmark;
import com.springmvc.repository.bookmark.BookmarkRepository;

@Service
public class BookmarkServiceImpl implements BookmarkService{

	@Autowired
	private BookmarkRepository bookmarkRepository;

	@Override
	public List<Bookmark> getBookmarkList(Long memberId) {
		// TODO Auto-generated method stub
		return bookmarkRepository.getBookmarkList(memberId);
	}

	@Override
	public void deleteBookmark(Long bookmarkId, Long memberId) {
		// TODO Auto-generated method stub
		bookmarkRepository.deleteBookmark(bookmarkId, memberId);
	}

	@Override
	public void insertBookmark(Long memberId, Long restaurantId) {
		// TODO Auto-generated method stub
		bookmarkRepository.insertBookmark(memberId, restaurantId);
	}
}
