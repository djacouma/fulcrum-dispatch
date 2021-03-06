async = require 'async'

searchable =
  search: (qs, cb) ->
    do_get = (callback) =>
      @get null, qs, (error, response, body) =>
        if error
          callback error
        else
          callback null, response, body
    do_process_http_errors = (response, body, callback) =>
      @process_http_errors response, (error) =>
        if error
          callback error
        else
          callback null, body
    tasks = [do_get, do_process_http_errors]
    async.waterfall tasks, cb

module.exports = searchable