import { readFileSync, writeFileSync } from "node:fs";
import { join, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const routesDir = join(__dirname, "..", "arteRoutes");

const langs = ["fr", "de", "en", "es", "pl", "it"];
const categoryCodes = [
  "CATEGORY_CIN",
  "CATEGORY_SER",
  "CATEGORY_ACT",
  "CATEGORY_CPO",
  "CATEGORY_DEC",
  "CATEGORY_HIS",
  "CATEGORY_SCI",
  "ARTE_CONCERT",
];

function collectPages(node, pages = []) {
  if (node.page) pages.push(node.page);
  if (node.children) {
    for (const child of Object.values(node.children)) {
      collectPages(child, pages);
    }
  }
  return pages;
}

const result = {};

for (const lang of langs) {
  const routes = JSON.parse(readFileSync(join(routesDir, `${lang}.json`), "utf8"));
  const pages = collectPages(routes);
  const byCode = new Map(pages.map((p) => [p.code, p]));

  result[lang] = categoryCodes
    .map((code) => {
      const page = byCode.get(code);
      if (!page) return null;
      const alt = page.alternativeLanguages?.find((a) => a.code === lang);
      const href = alt?.url;
      if (!href) return null;
      return { code, text: page.label.trim(), href };
    })
    .filter(Boolean);
}

writeFileSync(
  join(routesDir, "categories.json"),
  JSON.stringify(result, null, 2) + "\n"
);

console.log("Generated arteRoutes/categories.json");
