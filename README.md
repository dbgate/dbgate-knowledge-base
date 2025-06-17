# dbgate-knowledge-base
This is collection of common used SQL (and possibly noSQL) scripts. This collection is used primarily by [DbGate](https://dbgate.io), but it could be used by anyone else.

## Directory structure
There are 2 types in directory:
* with `folder-` prefix - these folders are used for logical structure for scripts. Nesting of these folder is not supported
* with `tag-` prefix - used for filtering scripts when syncing to local storage. Client (eg. DbGate) sends request with tags supported locally, **all** tags from the folders must be in directory structure

## SQL front matter
SQL front matter is metadata in YAML format at the beginning of SQL file. This concept is inspired by gohugo and Jekyll, which introduced front matter for markdown files. ([Front matter in Hugo](https://gohugo.io/content-management/front-matter/))

SQL front matter starts immediately at the SQL file start file mark `-- >>>` and ends with line containing only `-- <<<`. Every line of YAML content is prefixed with `-- `  prefix, so that the whole file remains valid SQL.

## Attributes used in DbGate Knowledge Base
- title: script title (default - file name without extension)
- description: script description (default - empty)
- icon: script icon (from [Material design icons](https://pictogrammers.com/library/mdi/), in format `mdi mdi-chart-pie`)
