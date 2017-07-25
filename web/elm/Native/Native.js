module.exports = {
    initPorts: function(app) {
        // receive something from Elm
        app.ports.toJs.subscribe(function (str) {
            console.log("got from Elm:", str);
        });
    }
};
