functor
import
   Request at 'Request.ozf'
   Response at 'Response.ozf'
   Http at 'Http.ozf'
   Socket_Server at 'Socket_Server.ozf'
   Headers at 'Headers.ozf'
export
   start:Start
   stop:Stop
   new_request:New_request
   new_response:New_response
   all_loaded:All_loaded
   reload:Reload
define
   proc {Start}
      skip
   end
   proc {Stop}
      skip
   end
   proc {Reload}
      skip
   end
   proc {All_loaded}
      skip
   end
   proc {New_request R}
      case R
      of request(Socket what(Method uri(abs_path Uri) Version) Headers) then
	 {Request.new Socket Method Uri Version {Headers.make Headers}}
      [] request(Socket what(Method uri(absoluteURI Uri) Version) Headers) then
	 {Request.new Socket Method Uri Version {Headers.make Headers}}
      [] request(Socket what(Method uri('*'=Uri Uri) Version) Headers) then
	 {Request.new Socket Method Uri Version {Headers.make Headers}}
      end
   end
   proc {New_response R}
      case R
      of response(Request Code Headers) then
	 {Response.new Request Code {Headers.new Headers}}
      end
   end
/*
   proc {Ensure_started}
      skip
   end
   proc {Ssl_cert_opts}
      skip
   end
   proc {With_server}
      skip
   end
   proc {Request_test}
      skip
   end
   proc {Single_http_GET_test}
      skip
   end
   proc {Single_https_GET_test}
      skip
   end
   proc {Multiple_http_GET_test}
      skip
   end
   proc {Multiple_https_GET_test}
      skip
   end
   proc {Hundred_http_GET_test}
      skip
   end
   proc {Hundred_https_GET_test}
      skip
   end
   proc {Single_128_http_POST_test}
      skip
   end
   proc {Single_128_https_POST_test}
      skip
   end
   proc {Single_2k_http_POST_test}
      skip
   end
   proc {Single_2k_https_POST_test}
      skip
   end
   proc {Single_100k_http_POST_test}
      skip
   end
   proc {Single_100k_https_POST_test}
      skip
   end
   proc {Multiple_100k_http_POST_test}
      skip
   end
   proc {Multiple_100K_https_POST_test}
      skip
   end
   proc {Hundred_128_http_POST_test}
      skip
   end
   proc {Hundred_128_https_POST_test}
      skip
   end
   proc {Do_GET}
      skip
   end
   proc {Do_POST}
      skip
   end
   proc {Client_request}
      skip
   end
   proc {Client_headers}
      skip
   end
   proc {Drain_reply}
      skip
   end
   */
end
