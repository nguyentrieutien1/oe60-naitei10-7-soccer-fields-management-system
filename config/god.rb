God.watch do |w|
  w.name = "rails-app"
  w.start = "cd /oe60-naitei10-7-soccer-fields-management-system && bin/rails server -e production"
  w.keepalive
end
