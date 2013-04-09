var log = function(s) {  
  if (document.readyState !== "complete") {  
    log.buffer.push(s);  
  } else {  
    document.getElementById("output").innerHTML += (s + "\n");  
  }  
}  
log.buffer = [];  
url = "ws://localhost:8000";  
w = new WebSocket(url);  
w.onopen = function() {  
  log("open");  
  w.send("thank you for accepting this WebSocket request");  
}  
w.onmessage = function(e) {  
  log(e.data);  
}  
w.onclose = function(e) {  
  log("closed");  
}  
window.onload = function() {  
  log(log.buffer.join("\n"));  
  document.getElementById("sendButton").onclick = function() {
    alert("dd");
    w.send(document.getElementById("inputMessage").value);  
  }  
} 
