/*********
*INDLUDES*
*********/
//irc
var irc = require('irc');
//translate
//nothing here at the moment because google sucks and bing is too annoying

/**********
*CONSTANTS*
**********/
var 	hostname    = 'irc.freenode.net'
	botname     = "huskybot";
var     roulettecall; //global reference for roulette function
var	chambers;	//global for roulette bullets
var 	channels    = ['#uconn'],
	compliments = ["boy your knees are smooth!","I love your neckbones!","you are dapper as fuck!","I like your teeth!","I'm sure you'll have very sexy babies!","You are pretty normal!"],
	facepalm    = [	"  .-'---`-.",
			",'          `.",
			"|             \\",
			"|              \\",
			"\\           _  \\",
			",\\  _    ,'-,/-)\\",
			"( * \\ \\,' ,' ,'-)",
			" `._,)     -',-')",
			"   \\/         ''/",
			"    )        / /",
			"   /       ,'-'",
			"   "]


/******
*FLAGS*
******/
var rouletteIsRunning = false;

/********************
*COMMAND LINE PARSER*
********************/
// process.stdin.resume();
// process.stdin.setEncoding('utf8');
/*//EXAMPLES
process.stdin.on('data', function (chunk) {
  process.stdout.write('data: ' + chunk);
});

process.stdin.on('end', function () {
  process.stdout.write('end');
});
*/

/***********************
*                      *
***********************/

var client = new irc.Client(hostname, botname, {
    channels: channels
});



client.addListener('pm', function (from, message) {
    console.log(from + ' => ME: ' + message);
});

process.stdin.on('data', function (chunk) {
  if(chunk.match(/ops/)){
      client.send("MODE", "#hackerthreads", "+o", "dash","just cause");
  }
  else{
      process.stdout.write(chunk + ' is not a command\n');
  }
});

client.addListener('message', function (from, to, message) {
    console.log(from + ' => ' + to + ': ' + message);
    if(message == "@commands" || message == "@help"){
        client.say(to,"Current commands: @compliment, @rroulette, @facepalm")
    }
    else if(message == "derp"){
    	client.say(to, "stfu");
    }
    else if(message == "hello "+to+"!"){
    	client.say(to, "hello loser!");
    }
    else if(message == "@compliment" || message == "~"){
    	var randomnumber=Math.floor(Math.random()*(compliments.length));
    	client.say(to, from + ": " + compliments[randomnumber]);
    }
    else if(message == "@twoscompliment"){
    	var randomnumber=Math.floor(Math.random()*(compliments.length));
    	client.say(to, from + ": " + compliments[randomnumber]);
    	var randomnumber=Math.floor(Math.random()*(compliments.length));
    	client.say(to, from + ": " + compliments[randomnumber]);
    }
    else if(message == "@rroulette"){
	if(!rouletteIsRunning){
		client.say(to, "/me puts a bullet in the chamber and snaps it shut");
		client.say(to, "use @trigger to take a shot pussy");
		var bullet=Math.floor(Math.random()*6);
		chambers = [0,0,0,0,0,0];
		chambers[bullet] = 1;
		roulettecall = function(from,message){
		    if(message == "@trigger"){
		        if(chambers[0] == 0){
		            client.say(to, "CLICK!");
		            chambers.shift();
		        }
		        else if(chambers[0] == 1){
		            client.say(to, "BANG!");
		            client.send("KICK", to, from, "DIDI MAO!");
		            client.removeListener('message' + to , roulettecall);
		        }
		    }
		}
		client.addListener('message' + to, roulettecall);
	}
	else{
		client.say(to, "roulette game is already being played, use @trigger to take a shot or do '@rroulette end' or '@rroulette restart' to end the current game");
	}
    }
    else if(message == "@rroulette end"){
	client.removeListener('message' + to, roulettecall);
	client.say(to, "russian roulette was ended. type @rroulette to start a new game");
    }
    else if(message == "@rroulette restart"){
	for(var i=0; i<chambers.length; i++){
		chambers[i] = 0;
	}
	var bullet=Math.floor(Math.random()*6);
	chambers[bullet] = 1;
	client.say(to, "/me empties out the bullet and re-places it into a new chamber.");
	
    }
    else if(message == "@facepalm"){
    	for(line in facepalm){
	    client.say(to,facepalm[line]);
	}
    }
    else if(message.match(/^@translate/)){
        /*
        var i = message.indexOf(' ');
        message = message.slice(i+1);

        i = message.indexOf(' ');
        var foreignLang = message.substring(0,i);
        var foreignText = message.substring(i+1);

        */
        client.say(to,'translate not currently working because google is a bunch of fucking fucks');


        
    }
});
