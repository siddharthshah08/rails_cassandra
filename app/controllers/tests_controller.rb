class TestsController < ApplicationController

   def index
     cluster = Cassandra.cluster
     session = cluster.connect("cassandra_keyspace")

     puts "params : #{params.inspect}"

   
     if(params["next"].nil? and params["prev"].nil?)
    	# first call, first page.
	first_page = true
        result  = session.execute("SELECT * FROM volume_usage WHERE id > 125 ALLOW FILTERING", page_size: 10, paging_state: nil)
        pages = {:next => ""} #add last
     else
	result  = session.execute("SELECT * FROM volume_usage WHERE id > 125 ALLOW FILTERING", page_size: 10, paging_state: params["next"])
	pages = {:prev => "", :next => ""} #add last
     end

     if(!result.last_page? and !result.paging_state.blank?)
   	next_paging_state = result.paging_state
	prev_paging_state = nil
     end
     url_without_params = request.url.split('?').first
     
     #new_params = request.query_parameters.merge({ next: next_paging_state.inspect, prev: prev_paging_state })
    
     response = {"data" => result}
     headers['Next'] = "#{url_without_params}?next=#{next_paging_state.inspect}&prev=#{prev_paging_state.inspect}"
     json_response(response)     

   end

end
