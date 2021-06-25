import { defineConfig } from 'vite';
import Levi from '@levi/vite-plugin-levi';

// https://vitejs.dev/config/
export default defineConfig({
  server: {
    port: 3010,
  },
  plugins: [
    Levi(),
  ],
});
