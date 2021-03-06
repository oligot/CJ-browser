note
	description: "Summary description for WSF_STARTS_WITH_MAPPING_I."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_STARTS_WITH_MAPPING_I

inherit
	WSF_ROUTER_MAPPING

	WSF_SELF_DOCUMENTED_ROUTER_MAPPING

feature {NONE} -- Initialization

	make (a_uri: READABLE_STRING_8; h: like handler)
		do
			set_handler (h)
			uri := a_uri
		end

feature -- Access

	associated_resource: READABLE_STRING_8
			-- Associated resource
		do
			Result := uri
		end

	uri: READABLE_STRING_8

feature -- Change

	set_handler	(h: like handler)
		deferred
		end

feature -- Documentation

	description: STRING_32 = "Starts-With-URI"

feature -- Status

	is_mapping (req: WSF_REQUEST; a_router: WSF_ROUTER): BOOLEAN
			-- <Precursor>
		local
			p: READABLE_STRING_8
			s: like based_uri
		do
			p := path_from_request (req)
			s := based_uri (uri, a_router)
			Result := p.starts_with (s)
		end

	routed_handler (req: WSF_REQUEST; res: WSF_RESPONSE; a_router: WSF_ROUTER): detachable WSF_HANDLER
			-- Return the handler if Current matches the request `req'.
		local
			p: READABLE_STRING_8
			s: like based_uri
		do
			p := path_from_request (req)
			s := based_uri (uri, a_router)
			if p.starts_with (s) then
				Result := handler
				a_router.execute_before (Current)
				execute_handler (handler, s, req, res)
				a_router.execute_after (Current)
			end
		end

feature {NONE} -- Execution

	execute_handler (h: like handler; a_start_path: like uri; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler `h' with `req' and `res' for Current mapping
		deferred
		end

feature {NONE} -- Implementation

	based_uri (a_uri: like uri; a_router: WSF_ROUTER): like uri
			-- `uri' prefixed by the `WSF_ROUTER.base_url' if any
		local
			s: STRING_8
		do
			if attached a_router.base_url as l_base_url then
				create s.make_from_string (l_base_url)
				s.append_string (a_uri)
				Result := s
			else
				Result := a_uri
			end
		end

note
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
