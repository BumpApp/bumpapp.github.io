/** Source for /assets/tailwind.css. Rebuild with `npm run build` after editing markup. */
module.exports = {
  content: ['./_layouts/**/*.html', './_includes/**/*.html', './_articles/**/*.md', './*.html',
            './!(_site|vendor|node_modules|careers-old|brand)/**/*.{html,md}'],
  theme: {
    fontFamily: { sans: ['Inter', 'system-ui', 'sans-serif'] },
    extend: {
      colors: {
        dark: '#0F172A',
        accent: '#0EA5E9',
        primary: '#10B981',
        surface: '#F8FAFC',
        'surface-hover': '#ECFDF5',
        'dark-hover': '#1E293B',
        'primary-hover': '#ECFDF5'
      }
    }
  },
  plugins: [require('@tailwindcss/typography')]
}
