# DataSD

## Installation

To install you need [Node.js][nodejs] (`>0.10.0`) and [Ruby][rubylang] (`> 1.9`)
for Jekyll. 

## Usage

#### `gulp`

The default task, this will automatically compile and open the site in your
browser. A watch task runs in the background and detects when any files change,
recompiles them if nessecary and updates your browser with BrowserSync.


#### `gulp build`

Almost the same as the default `gulp` task, but this won't start up a
preview/LiveReload server and open the browser, it will only build your site.

#### `gulp publish`

This will first run `gulp build` to make sure the changes you've made to your
site are included and then optimize all your assets (images, HTML, CSS, JS++).
If you want to display your optimized site to make sure everything is working
run `gulp serve:prod` to see the changes.

#### `gulp deploy`

This will either upload your site to Amazon S3, Rsync your files to your server
or push them to GitHub Pages.

### Individual tasks

A lot of the tasks are built up of smaller tasks that can be run individually.
For example, the `gulp publish` task first runs `gulp build` (that also runs
`jekyll:prod`, `styles` and `images`) and `clean:prod` and then runs the `html`
and `copy` commands (`html` to optimize your site and `copy` to copy over some
files that `html` misses). If you want to you can run any of these tasks without
invoking their "parent" task. If you only wanted to optimize your assets and
such, run `gulp html` and it won't run any of the tasks used with `gulp
publish`.

For all the different tasks that can be run, see the [gulpfile][gulpfile] and
look through the code. Everything is commented and you can edit, change or
remove what you want/need.


## Thank Yous
This is heavily based on and was generated with [Generator Jekyllized](https://github.com/sondr3/generator-jekyllized).  There's also plenty of open source software running behind this project.