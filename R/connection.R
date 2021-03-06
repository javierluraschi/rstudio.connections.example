connect <- function(host = "test://localhost") {
  observer <- getOption("connectionObserver")
  icons <- system.file(file.path("icons"), package = "rstudio.connections")

  if (is.null(observer)) return()

  observer$connectionOpened(
    # connection type
    type = "Test",

    # name displayed in connection pane
    displayName = host,

    # host key
    host = host,

    # connection code
    connectCode = paste0("connect(\"", host, "\")"),

    # disconnection code
    disconnect = function() {
      observer$connectionClosed(type = "Test", host = host)
    },

    listObjectTypes = function () {
      list(
        table = list(contains = "data")
      )
    },

    # table enumeration code
    listObjects = function(type = "table") {
      data.frame(
        name = c("table1", "table2"),
        type = c("table", "table"),
        stringsAsFactors = FALSE
      )
    },

    # column enumeration code
    listColumns = function(table) {
      data.frame(
        name = c("col1", "col2"),
        type = c("character", "numeric"),
        stringsAsFactors = FALSE
      )
    },

    # table preview code
    previewObject = function(rowLimit, table) {
      View(iris)
    },

    # other actions that can be executed on this connection
    actions = list(
      "Help" = list(
        icon = file.path(icons, "help.png"),
        callback = function() {
          message("Help command")
        }
      )
    ),

    # raw connection object
    connectionObject = list(name = host)
  )
}
