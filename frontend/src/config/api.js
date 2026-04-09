// API Configuration
// This file centralizes all API configuration for the application

// Default to localhost for development
const DEFAULT_API_URL = 'http://localhost:8000';

// Get the API URL from environment variables or use default
export const API_URL = process.env.REACT_APP_BACKEND_URL || process.env.REACT_APP_API_URL || DEFAULT_API_URL;

// API endpoints
export const ENDPOINTS = {
  // Auth
  AUTH_LOGIN: '/api/auth/login',
  AUTH_ME: '/api/auth/me',
  AUTH_LOGOUT: '/api/auth/logout',
  
  // Blog
  BLOG_POSTS: '/api/blog/posts',
  BLOG_POST: (slug) => `/api/blog/posts/${slug}`,
  
  // Testimonials
  TESTIMONIALS: '/api/testimonials',
  TESTIMONIAL: (id) => `/api/testimonials/${id}`,
  
  // Contact
  CONTACT: '/api/contact',
  CONTACT_REQUESTS: '/api/contact/requests',
  
  // Uploads
  UPLOADS: '/api/uploads',
  UPLOAD: (fileId) => `/api/uploads/${fileId}`,
  UPLOAD_THUMBNAIL: (fileId) => `/api/uploads/${fileId}/thumbnail`,
  
  // Health
  HEALTH: '/api/health',
};

// Full URL builder
export const getFullUrl = (endpoint) => `${API_URL}${endpoint}`;

// Axios default config
export const axiosConfig = {
  baseURL: API_URL,
  withCredentials: true,
  headers: {
    'Content-Type': 'application/json',
  },
};

export default {
  API_URL,
  ENDPOINTS,
  getFullUrl,
  axiosConfig,
};
