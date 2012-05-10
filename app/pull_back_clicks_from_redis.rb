def pull_back_clicks_from_redis
  $redis.keys("click:*").each do |click_key|
    Click.create(:link_id         => value_from_hash_and_key(click_key, "link_id"), 
                 :click_uuid      => value_from_hash_and_key(click_key, "click_uuid"),
                 :ref_url         => value_from_hash_and_key(click_key, "ref_url"),
                 :ref_user_agent  => value_from_hash_and_key(click_key, "ref_user_agent"),
                 :ref_ip          => value_from_hash_and_key(click_key, "ref_ip"))
    delete_key(click_key)
  end
end


def value_from_hash_and_key(hash, key)
  return $redis.hget(hash, key)
  return nil    
end

def delete_key(key)
  $redis.del(key)
end

pull_back_clicks_from_redis()