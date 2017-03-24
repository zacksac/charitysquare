var socket = require( 'socket.io' );
var express = require( 'express' );
var http = require( 'http' );

var app = express();
var server = http.createServer( app );

var io = socket.listen( server );

io.sockets.on( 'connection', function( clients ) {
        console.log('--------------------------getconnect-------------------------')
	    
          console.log('client connected -----------'+clients.length+'-------------');
           
             for( var i=0, len=clients.length; i<len; ++i ){
                var c = clients[i];
               // console.log(c);
                console.log('---------------------------------------------------')
            
            }

        clients.on('storeClientInfo', function (data) {
          
            clients.userId = data.customId;
            

        });
        clients.on('fire',function(data){
          // io.sockets.emit( 'fire_response', { name: data.fire} );
        })


        clients.on('getclients',function(){
            console.log('getclients')
            //console.log(clients);
            
        })


        io.sockets.on('disconnect', function (data) {

            for( var i=0, len=clients.length; i<len; ++i ){
                var c = clients[i];

                if(c.clientId == socket.id){
                    clients.splice(i,1);
                    break;
                }
            }

        });

   ////////////////////////////////sample test message function ///////////////////

    clients.on('message',function(data){
      console.log(data);
    io.sockets.emit( 'message', { name: data.name, message: data.message ,test:"socket chat"} );

    });
   ///////////////////////////////end of sample maessage function ////////////////////
       



});

server.listen( 8000 );