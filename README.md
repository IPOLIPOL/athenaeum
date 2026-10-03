# Athenaeum

Personal literature library and review notes.

The original project was a hand-authored static HTML page. The current implementation changes the direction:

> **The literature data is the source; HTML is a generated artefact.**

Common Lisp is the implementation language and `defstruct` is the canonical in-memory domain model.

## Architecture

```text
data/library.lisp
        |
        v
   defstruct model
        |
        v
  Common Lisp renderer
        |
        v
     site/index.html
        |
        +--> site/styles.css
        +--> site/keyboard.js
        +--> site/assets/
        +--> site/docs/
```

The important separation is:

- `data/` — authored literature content
- `src/model.lisp` — domain structures
- `src/html.lisp` — HTML rendering
- `src/styles.css` — presentation
- `src/keyboard.js` — small browser behaviour
- `site/` — disposable generated output

`site/` is deliberately ignored by Git.

## Domain model

The current model contains:

- `author`
- `image`
- `quote`
- `book`
- `category`
- `library`

A `book` contains bibliographic information and review material, while a `category` contains books.

The model can grow independently of the HTML representation.

## Requirements

A Common Lisp implementation is required. The project is tested with SBCL on the development side and GitHub Actions installs SBCL for Pages builds.

No Quicklisp libraries are required by the current implementation.

## Local build

From the repository root:

```sh
./scripts/build.sh
```

The generated website is written to:

```text
site/
```

To run the smoke tests:

```sh
./scripts/test.sh
```

## GitHub Pages

`.github/workflows/pages.yml` builds the site and deploys the `site/` directory using GitHub Pages.

The repository's GitHub Pages configuration should use **GitHub Actions** as the source.

## Adding a book

Books are added to `data/library.lisp`.

For example:

```lisp
(book*
 "example-book"
 "Example Book"
 :authors '("Author Name")
 :year 2026
 :publisher "Publisher"
 :edition "1st edition"
 :description "Personal review notes."
 :url "https://example.org"
 :cover "assets/example-book.jpg")
```

The HTML renderer does not need to be changed for an ordinary new book.

## Design rule

Do not put literary content into `site/index.html`.

If a generated page needs new information, first decide whether that information belongs in the domain model. Then add it to the model/data and update the renderer.

This keeps the repository from returning to the original hand-authored-HTML architecture.

## Migration from the original repository

The existing `assets/` and `docs/` directories should be retained. The build script copies them into the generated site.

The existing literature content has been moved from `index.html` into `data/library.lisp`. The original project currently contains five categories and fourteen real book entries; the placeholder `Book 1` / `Book N` entries from the old page are intentionally not represented as books.
