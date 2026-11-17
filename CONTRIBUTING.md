# Contributing

Thank you for helping. A typo fix is as welcome as a new page.

## The quick way

Use **Edit page** at the bottom of any page on
[docs.ripplefx.app](https://docs.ripplefx.app). GitHub forks the repository
for you, you edit the Markdown in the browser and open a pull request.

## Running the site

You need Node 22, pnpm 11 and [Git LFS](https://git-lfs.com) (the
screenshots are stored in it):

```sh
git lfs install
git clone https://github.com/ConnectingTheDots-DCWK/ripple_effect_docs.git
cd ripple_effect_docs
pnpm install
pnpm dev          # http://localhost:4321
```

Before opening a pull request:

```sh
pnpm exec prettier --check .
pnpm check        # astro check
pnpm build
```

The same three run on every pull request.

## Where things are

- **Pages** are under `src/content/docs/`, English at the top and Italian
  under `it/`. A new page also needs an entry in the sidebar in
  `astro.config.mjs`.
- **Every page is one of four kinds**: a tutorial (learning by doing), a
  how-to guide (one task, for someone who knows the basics), a reference
  (facts to look up) or an explanation (why things are the way they are).
  Keep a page to its kind, and link to the others rather than folding them in.
- **Some pages are generated** from the app's source and must not be edited
  by hand: `reference/nodes.mdx`, `src/node-types.ts` and the node
  screenshots. To change one, open an issue saying what is wrong and we will
  fix it at the source.
- **`about/licensing` and `about/what-the-app-sends`** restate legal
  documents and stay in English only.

## Licensing

The documentation is under CC BY 4.0 and the site's code under MIT (see
`README.md`). By opening a pull request you agree that your contribution is
licensed under the same terms.
