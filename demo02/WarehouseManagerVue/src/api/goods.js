import axios from 'axios';

// 获取物品名映射
export const getGoodsNameMap = () => {
  return axios.get('/goods/nameMap');
};