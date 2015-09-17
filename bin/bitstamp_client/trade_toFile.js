#! /usr/bin/env node

var daemon = require('daemon')();

var fs = require('fs'),
    Bitstamp = require('bitstamp-ws');

var ws = new Bitstamp();
var homeDir = process.env.HOME;

//todo get last bid from bitstamp by http query
fs.readFile(homeDir+'/tmp/bitstamp_trade.log', function (err,data) {
    if(err) {
        fs.writeFile('/dev/shm/bitstamp_trade.log','[N/A]');
    }
    else {
        fs.writeFile('/dev/shm/bitstamp_trade.log',data);
    }

    ws.on('trade', function (trade) {
        var data = trade.price +'/'+trade.amount;
        fs.writeFile('/dev/shm/bitstamp_trade.log',data);
        console.log(trade);
    });

});

process.on('exit', shutdown);
process.on("SIGINT",shutdown);
process.on("SIGTERM",shutdown);

function shutdown() {
    fs.readFile('/dev/shm/bitstamp_trade.log', function (err,dataRaw) {
        var data = '['+dataRaw+']';
        fs.writeFile(homeDir+'/tmp/bitstamp_trade.log',data, function(){
            process.exit(0);
        });
    });
}
