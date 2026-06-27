/** @type {import('tailwindcss').Config} */
// CBASH design tokens — dark-first, lime-green (#00ff88) identity, mono-forward.
export default {
  content: ["./src/**/*.{astro,html,js,ts,jsx,tsx,md,mdx}"],
  darkMode: ["class"],
  theme: {
    extend: {
      colors: {
        border: "hsl(var(--border))",
        background: "hsl(var(--bg))",
        foreground: "hsl(var(--text))",
        surface: { DEFAULT: "hsl(var(--surface))", 2: "hsl(var(--surface-2))" },
        muted: { foreground: "hsl(var(--text-muted))" },
        green: { DEFAULT: "var(--green)", strong: "var(--green-strong)" },
      },
      fontFamily: {
        sans: ["var(--sans)"],
        mono: ["var(--mono)"],
      },
      borderRadius: {
        sm: "var(--r-sm)",
        md: "var(--r-md)",
        lg: "var(--r-lg)",
      },
      maxWidth: { content: "1160px" },
      keyframes: {
        "fade-up": { "0%": { opacity: "0", transform: "translateY(14px)" }, "100%": { opacity: "1", transform: "none" } },
        blink: { "50%": { opacity: "0" } },
      },
      animation: {
        "fade-up": "fade-up 0.5s ease-out both",
        blink: "blink 1.1s step-end infinite",
      },
    },
  },
  plugins: [],
};
