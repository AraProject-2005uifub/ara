note
	description: "[
				application execution
			]"
	date: "$Date: 2016-10-21 09:45:18 -0800 (Fri, 21 Oct 2016) $"
	revision: "$Revision: 99331 $"

class
	ARAPROJECT_EXECUTION
	

inherit

  
	WSF_EXECUTION
  



create
	make

feature {NONE} -- Initialization


feature -- Execution

	execute
			-- Use `request' to get data for the incoming http request
			-- and `response' to send response back to the client
		local
			mesg: WSF_PAGE_RESPONSE
		do
				--| As example, you can use {WSF_PAGE_RESPONSE}
				--| To send back easily a simple plaintext message.
			create mesg.make_with_body ("Hello Eiffel Web")
			response.send (mesg)
		end




end
