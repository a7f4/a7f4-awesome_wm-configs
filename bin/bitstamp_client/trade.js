/**
 * Created by Aleksandr Block on 7/19/15.
 */

var fs = require('fs');
var Bitstamp = require('bitstamp-ws');

var ws = new Bitstamp();
ws.on('trade', function (trade) {

    console.log('new trade:', trade);
});
