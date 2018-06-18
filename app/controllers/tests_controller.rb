class TestsController < ApplicationController

  def index
    raise BadRequest, "Invalid request : #{e.message}"
    begin
      cluster = Cassandra.cluster
      session = cluster.connect("cassandra_keyspace")
      next_page = !params["next"].blank? ? params["next"].split("q").map{ |x| x.to_i }.pack("c*") : nil
      page_size = params["page_size"].present? ? params["page_size"] : nil
      result  = session.execute("SELECT * FROM volume_usage", page_size: page_size, paging_state: next_page)
      paging_links = get_paging_links(params, result.paging_state)

      response = { "data" => result }
      response.merge!(paging_links)
      json_response(response)
    rescue Exception => e
        raise BadRequest, "Invalid request : #{e.message}"
    end
  end
end
