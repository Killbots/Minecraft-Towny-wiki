# ModernMC Towny Wiki

The ModernMC Towny Wiki is a static website for server information, player guides, maps, rules, and shop links. The site is built from HTML, CSS, JavaScript, and local image and font assets; it does not require a package-manager build step.

## Preview locally

From the repository root, start a simple static web server:

```sh
python3 -m http.server 8000
```

Open <http://localhost:8000/> in a browser. Stop the server with `Ctrl+C`.

## Repository layout

- `index.html` — home page
- `pages/` — rules, guide index, maps, staff, voting, and shop pages
- `guides/` — individual player guides
- `assets/` — shared styles, scripts, images, and fonts
- `deploy/` — NGINX configuration and production deployment instructions

Pages link to shared resources with relative paths. When adding a page, use the existing page structure and include the shared navigation, styles, and footer so it remains consistent with the rest of the site.

## Updating server information

Keep commands, rewards, prices, plugin names, and item details aligned with the current server configuration. When a value can change in game, direct players to the relevant menu or current server help instead of presenting it as permanent.

## Branch and release workflow

- Build and make ongoing changes on the `Dev` branch.
- For a version update, open a pull request from `Dev` into `main` and review the changes before merging.
- Keep deployment-only helpers and local files out of commits. The root `.gitignore` excludes `publish.sh`.

## Deployment

See [`deploy/README.md`](deploy/README.md) for publishing the static files with NGINX, configuring the `modernmc.ca` host, and enabling HTTPS.
