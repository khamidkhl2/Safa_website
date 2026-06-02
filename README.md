# Safa Website

Static Vercel-ready website for Safa.

## Local preview

```sh
python3 -m http.server 4173 --directory website
```

Then open `http://127.0.0.1:4173`.

Local pages:

- Home: `http://127.0.0.1:4173/`
- Privacy: `http://127.0.0.1:4173/privacy/`
- Terms: `http://127.0.0.1:4173/terms/`
- Support: `http://127.0.0.1:4173/support/`

## Deploy to Vercel

1. Push this repository to GitHub.
2. In Vercel, import the repository.
3. Set the root directory to `website`.
4. Leave the framework preset as `Other`.
5. Build command: leave empty.
6. Output directory: leave empty.
7. Deploy.

## App Store Connect URLs

After deployment, use:

- Privacy Policy URL: `https://your-domain.com/privacy/`
- Terms of Use URL: `https://your-domain.com/terms/`
- Support URL: `https://your-domain.com/support/`

The support route redirects to `https://t.me/safaprayersupport`.

## Promo assets

The polished portrait promo images are in `assets/promo/` and are generated from the current app screenshots.

To regenerate them after updating app screenshots:

```sh
swift website/tools/generate_promo_assets.swift
```
