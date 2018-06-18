module Response
  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def get_paging_links (params, paging_state = nil)
    paging_hash = {}
    url_without_params = request.url.split('?').first
    puts "request.query_parameters #{request.query_parameters.delete('next').to_param.nil?}"
    paging_hash[:first] = {
      :href => "#{url_without_params}"  
    }
    if !paging_state.nil?
      new_params = request.query_parameters.merge({
          next: paging_state.bytes.join('q')
        })
      paging_hash[:next] = {
        :href => "#{url_without_params}?#{new_params.to_param}"
      }
    end
    paging_hash
  end

  def hash_to_query(hash)
    q_params = URI.encode(hash.map{|k,v| "#{k}=#{v}"}.join("&"))
    puts "q_params : #{q_params}"
    q_params
  end
end
