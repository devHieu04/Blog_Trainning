// config/webpack/environment.js

const { environment } = require('@rails/webpacker');

// Import Tailwind CSS
const tailwindcss = require('tailwindcss');
const autoprefixer = require('autoprefixer');

// Thêm plugin Tailwind CSS vào environment
environment.loaders.append('style', {
  test: /\.css$/,
  use: [
    { loader: 'style-loader' },
    { loader: 'css-loader' },
    {
      loader: 'postcss-loader',
      options: {
        postcssOptions: {
          plugins: [tailwindcss, autoprefixer],
        },
      },
    },
  ],
});

module.exports = environment;
