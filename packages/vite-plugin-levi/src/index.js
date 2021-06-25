import Vue from '@vitejs/plugin-vue';

export const Levi = (config = {}) => ({
  name: 'levi',
});

export default function framework(config) {
  return [
    Vue(config),
    Levi(config),
  ];
}
