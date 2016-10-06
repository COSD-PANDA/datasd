# DataSD

## Installation

### Requirements

Clone or fork this repository and ensure the following tools are available:
- [Node.js](https://github.com/nodejs) (`>0.10.0`)
- [Ruby](https://github.com/ruby) (`> 1.9`)
for Jekyll
- [Bundler](https://github.com/bundler/bundler) to track and install specific Ruby gems
- [Gulp](https://github.com/gulpjs/gulp) for automated builds and project compiling

### Install prerequisites
From within the project folder, install the prerequisites by running the following commands:
```bash
npm install
bower install
bundle install
```

## Development and deployment

Make changes only in the `src/` folder.

#### `gulp`

The default task, this will automatically compile and open the site in your browser. A watch task runs in the background and detects when any files change, recompiles them if necessary and updates your browser with BrowserSync. The default dev URL is `http://localhost:3000`. You can use an alternative port number by adjusting the `process.env.PORT` value in the [gulpfile](gulpfile.js).


#### `gulp build`

Almost the same as the default `gulp` task, but this won't start up a preview/LiveReload server and open the browser, it will only build your site.

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

For all the different tasks that can be run, see the [gulpfile](gulpfile.js) and
look through the code. Everything is commented and you can edit, change or
remove what you want/need.


## Thank You’s
This is heavily based on and was generated with [Generator Jekyllized](https://github.com/sondr3/generator-jekyllized). There's also plenty of open source software running behind this project.
