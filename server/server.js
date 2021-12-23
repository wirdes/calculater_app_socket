const WebSocket = require("ws");
const wss = new WebSocket.Server({ port: 3000 });
wss.on("connection", (ws) => {
  ws.on("message", (message) => {
    
    let answer;
    let control = 0;
    try {
      answer = eval(message.toString());
    } catch (err) {
      control = 1;
    }
    if (control === 0) {
      ws.send("Cevap: " + answer);
    } else {
      ws.send(
        "boşluk bırakmadan matematik işleminizi yazını ( 2+2*5 )!"
      );
    }
  });
  ws.send("Lütfen boşluksuz işlemini yaz");
});
