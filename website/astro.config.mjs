// @ts-check
import { defineConfig } from "astro/config";
import tailwind from "@astrojs/tailwind";
import icon from "astro-icon";

// GitHub Pages project site: https://cminhho.github.io/cbash/
export default defineConfig({
  site: "https://cminhho.github.io",
  base: "/cbash",
  output: "static",
  integrations: [icon(), tailwind({ applyBaseStyles: false })],
});
