import { instance } from './Axios';

// 获取验证码
export function sendCode(phone: string) {
  // promise
  return instance.get('/word/user/code', { params: { phone: phone } });
}

interface loginData {
  phone: string,
  code: string
}

interface passwordLoginData {
  phone: string,
  password: string
}

// 登录
export function login(phone: string, code: string) {
  const data: loginData = { phone: phone, code: code };
  return instance.post('/word/user/login', data);
}

// 密码登录
export function passwordLogin(phone: string, password: string) {
  const data: passwordLoginData = { phone: phone, password: password };
  return instance.post('/word/user/passwordLogin', data);
}

interface CreatePostData {
  rightCount: number,
  answeredCount: number,
  timeUsed: number
}

// 打卡
export function createPost(post: CreatePostData) {
  return instance.post('/word/post/create', post);
}

// 获取全部打卡列表
export function getAllPost(page: number, size: number) {
  return instance.get('/word/post/getAll', { params: { page: page, size: size } });
}

// 点赞
export function like(postId: number) {
  return instance.get('/word/like/create', { params: { postId: postId } });
}

// 取消点赞
export function cancelLike(postId: number) {
  return instance.get('/word/like/cancel', { params: { postId: postId } });
}

// 获取登录用户信息
export function info() {
  return instance.get('/word/user/info');
}

// 获取我的登录打卡记录
export function getMyPost(page: number, size: number) {
  return instance.get('/word/post/getmine', { params: { page: page, size: size } });
}