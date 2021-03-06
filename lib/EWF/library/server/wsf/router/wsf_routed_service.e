note
	description: "Summary description for {WSF_ROUTED_SERVICE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_ROUTED_SERVICE

feature -- Initialization

	initialize_router
			-- Initialize router
		do
			create_router
			setup_router
		end

	create_router
			-- Create `router'	
			--| could be redefine to initialize with proper capacity
		do
			create router.make (10)
		ensure
			router_created: router /= Void
		end

	setup_router
			-- Setup `router'
		require
			router_created: router /= Void
		deferred
		end

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Dispatch the request
			-- and if you dispatch is found, execute the default procedure `execute_default'
		do
			if attached router.dispatch_and_return_handler (req, res) as p then
				-- executed
			else
				execute_default (req, res)
			end
		end

	execute_default (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Default procedure
		local
			msg: WSF_DEFAULT_ROUTER_RESPONSE
		do
			create msg.make_with_router (req, router)
			res.send (msg)
		end

feature -- Access

	router: WSF_ROUTER
			-- Router used to dispatch the request according to the WSF_REQUEST object
			-- and associated request methods

;note
	copyright: "2011-2012, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
