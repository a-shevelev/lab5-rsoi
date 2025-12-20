package service

import (
	"gateway-api/internal/client"
	"gateway-api/internal/dto"
)

type LibraryService struct {
	Client *client.Library
}

func NewLibraryService(c *client.Library) *LibraryService {
	return &LibraryService{Client: c}
}

func (s *LibraryService) GetLibraries(city string, page, size int, token string) (*dto.LibraryPaginationResponse, error) {
	return s.Client.GetLibraries(city, page, size, token)
}

func (s *LibraryService) GetLibraryBooks(libraryUid string, page, size int, showAll bool, token string) (*dto.LibraryBookPaginationResponse, error) {
	return s.Client.GetLibraryBooks(libraryUid, page, size, showAll, token)
}
