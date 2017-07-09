const webpack = require('webpack');
var merge = require('webpack-merge');
var CopyWebpackPlugin = require('copy-webpack-plugin');
var HTMLWebpackPlugin = require('html-webpack-plugin');
var path = require('path');

module.exports = {
    entry: [
        // "bootstrap-loader",
        "./web/static/js/app.js",
    ],
    output: {
        path: path.resolve(__dirname, "../priv/static/assets"),
        filename: "app.js",
        publicPath: "/assets/"
    },
    resolve: {
        modules: [
            path.join(__dirname, "..", "web/static/js"),
            path.join(__dirname, "..", "web/elm"),
            path.join(__dirname, "..", "node_modules")
        ],
        extensions: ['.js', '.jsx', '.elm', '.scss', '.png']
    },
    module: {
        rules: [
            {
                test: /\.css$/,
                // loader: "style-loader!css-loader?importLoaders=1"
                use: [
                    'style-loader',
                    'css-loader'
                ]
            },
            {
                test: /\.jsx?$/,
                exclude: /node_modules/,
                loader: "babel-loader",
                query: {
                    presets: ["es2015"]
                }
            },
            {
                test: /\.elm$/,
                exclude: [/elm-stuff/, /node_modules/],
                use: [
                    {
                        loader: 'elm-assets-loader',
                        options: {
                            module: 'Assets',
                            tagger: 'AssetPath'
                        }
                    },
                    // 'elm-hot-loader',
                    'elm-webpack-loader?forceWatch=true'
                ]
            },
            {
                test: /\.scss$/,
                exclude: [
                    /elm-stuff/, /node_modules/
                ],
                loaders: ["style-loader", "css-loader", "sass-loader"]
            },
            {
                test: /\.css$/,
                exclude: [
                    /elm-stuff/, /node_modules/
                ],
                loaders: ["style-loader", "css-loader"]
            },
            {
                test: /\.(woff2?|svg|png)$/,
                loader: 'url-loader?limit=10000'
            },
            {
                test: /\.(ttf|eot)$/,
                loader: 'file-loader'
            }
        ]
    },
    plugins: [
        new webpack.ProvidePlugin({
            $: "jquery",
            jQuery: "jquery",
            "window.jQuery": "jquery",
            Tether: "tether",
            "window.Tether": "tether",
            Alert: "exports-loader?Alert!bootstrap/js/dist/alert",
            Button: "exports-loader?Button!bootstrap/js/dist/button",
            Carousel: "exports-loader?Carousel!bootstrap/js/dist/carousel",
            Collapse: "exports-loader?Collapse!bootstrap/js/dist/collapse",
            Dropdown: "exports-loader?Dropdown!bootstrap/js/dist/dropdown",
            Modal: "exports-loader?Modal!bootstrap/js/dist/modal",
            Popover: "exports-loader?Popover!bootstrap/js/dist/popover",
            Scrollspy: "exports-loader?Scrollspy!bootstrap/js/dist/scrollspy",
            Tab: "exports-loader?Tab!bootstrap/js/dist/tab",
            Tooltip: "exports-loader?Tooltip!bootstrap/js/dist/tooltip",
            Util: "exports-loader?Util!bootstrap/js/dist/util",
        })
        // new webpack.optimize.UglifyJsPlugin({
        //     minimize: true,
        //     compress: true
        // })
    ]
};
