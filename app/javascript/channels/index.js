// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.

const channels = require.context('.', true, /_channel\.js$/)
channels.keys().forEach(channels)

window.onload = function() {
    console.log("Before mounting")
    ZoomMtg.setZoomJSLib('https://source.zoom.us/1.7.8/lib', '/av');
    ZoomMtg.preLoadWasm();
    ZoomMtg.prepareJssdk();
    console.log("After mounting")
    document.getElementById("attend_session").addEventListener("click", function (e) {
      e.preventDefault()
      $.ajax({
        url: "/get_signature",
        method: 'POST',
        data: {
          meeting_number: $(this).data('meeting-id'),
          role: 0,
          password: $(this).data('password'),
          username: $(this).data('username'),
          email: $(this).data('email')
        },
        success: function(response) {
          ZoomMtg.init({
            leaveUrl: window.location.href,
            success: function () {
              console.log(response);
              console.log("signature", response.signature);
              ZoomMtg.join({
                signature: response.signature,
                meetingNumber: response.meetingNumber,
                userName: response.userName,
                apiKey: response.apiKey,
                userEmail: response.userEmail,
                passWord: response.password,
                success: function (res) {
                  console.log("join meeting success");
                  console.log("get attendeelist");
                  ZoomMtg.getAttendeeslist({});
                  ZoomMtg.getCurrentUser({
                    success: function (res) {
                      console.log("success getCurrentUser", res.result.currentUser);
                    },
                  });
                },
                error: function (res) {
                  console.log(res);
                },
              });
            },
            error: function (res) {
              console.log(res);
            },
          });
        }
      });
    });
  }