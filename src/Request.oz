functor
import
   Headers at 'Headers.ozf'
export
   get_header_value:Get_Header_Value
   get_primary_header_value:Get_Primary_Header_Value
   get:Get
   dump:Dump
   send:Send
   recv:Recv
   recv:Recv_Body
 /*  stream_body:Stream_Body
   start_response:Start_Response
   start_response_length:Start_Response_Length
   start_raw_response:Start_Raw_Response
   response:Response
   ok:Ok
   not_found:Not_Found
   parse_post:Parse_Post
   parse_qs:Parse_Qs
   should_close:Should_Close
   cleanup:Cleanup
   parse_cookie:Parse_Cookie
   get_cooxie_value:Get_Cookie_Value
   serve_file:Serve_File
   accepted_encodings:Accepted_Encodings*/
define
   fun {Get_Header_Value K}
      {Headers.get_value K Headers}
   end
   fun {Get_Primary_Header_Value K}
      {Headers.get_primary_value K Headers}
   end
   fun {Get Type}
      case Type
      of socket then Socket
      [] scheme then
	 case {Socket.type Socket}
	 of plain then http
	 [] ssl then https
	 end
      [] method then Method
      [] version then Version
      [] headers then Headers
      [] peer then
	 case {Socket.peername Socket}
	 of ok( address(10 _ _ _) _Port) then
	    case {Get_Header_Value "x-forwarded-for"}
	    of undefined then inet
	    [] Hosts then strip
	    end
	 [] ok(address(127 0 0 1) Port) then
	    case {Get_Header_Value "x-forwarded-for"}
	    of undefined then "127.0.0.1"
	    [] Hosts then strip
	    end
	 [] ok( address(Addr Port)) then inet
	 end
      [] path then
	 case {Erlang.get Save_Path}
	 of undefined then undefined
	 [] Cached then Cached
	 end
      [] body_length then
	 case {Erlang.get Save_Path}
	 of undefined then undefined
	 [] cached(Cached) then Cached
	 end
      [] range then
	 case {Erlang.get Save_Path}
	 of undefined then undefined
	 [] RawRange then {Http.parse_range_request RawRange}
	 end
      end
      fun {Dump}
	 dump(method:Method version:Version raw_path:RawPath headers:{Headers.to_list Headers})
      end
      fun {Send Data}
	 case {Socket.send Socket Data}
	 of ok then ok
	 [] _ then exit(normal)
	 end
      end
      fun {Recv Length Timeout}
	 case {Socket.recv Socket Length Timeout}
	 of ok(Data) then true
	 [] _ then exit(normal)
	 end
      end
      fun {Body_Length}
	 case {Get_Header_Value "transfer-encoding"}
	 of undefined then undefined
	 [] "chunked" then chunked
	 [] Unknown then unknown_transfer_encoding(Unknown)
	 end
      end
      fun {Recv_Body}
	 {Recv_Body 1024}
      end
      fun {Recv_Body MaxBody}
	 skip
      end
   end
end
