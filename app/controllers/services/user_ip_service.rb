module Services
  module UserIpService
    # Because determining the clients real IP is hard, simply return the first
    # value of the x-forwarded_for, checking it's an IP. This will probably be
    # enough for our basic monitoring
    def user_ip(forwarded_for = "")
      first_ip_string = forwarded_for.split(",").first
      Regexp.union([Resolv::IPv4::Regex, Resolv::IPv6::Regex]).match(first_ip_string) && first_ip_string
    end
  end
end
