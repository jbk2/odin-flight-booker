const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  mode: 'jit',
  purge: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
  ],
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
        display: ['Racing Sans One', 'sans-serif'],
        label: ['Nunito Sans', 'sans-serif'],
        helvetica: ['Helvetica'],
        ariel: ['Ariel'],
        jost: ['Jost', 'sans-serif'],
      },
      colors: {
        transparent: 'transparent',
        current: 'currentColor',
        'header-green': '#14453D',
        'light-blue': '#42BFDD',
        'med-green': '#C84630',
      },
      keyframes: {
        fadeIn: {
          '0%': { opacity: '0' },
          '100%': { opacity: '1' },
        },
      },
      animation: {
        'fade-in': 'fadeIn 0.2s ease-out',
      },
    },
    container: {
      center: true,
      padding: '2rem',
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
    require("daisyui"),
  ],
  daisyui: {
    themes: ["light", "dark", "cupcake"],
  },
}