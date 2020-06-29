#!/usr/bin/perl
{
package MyWebServer;
 
use HTTP::Server::Simple::CGI;
use base qw(HTTP::Server::Simple::CGI);

use CGI;


my %dispatch = (
#    '/hello' => \&resp_hello,
# ...
);
 
sub handle_request {
    my $self = shift;
    my $cgi  = shift;
   
    my $path = $cgi->path_info();
    my $handler = $dispatch{$path};
 
    if (ref($handler) eq "CODE") {
        print "HTTP/1.0 200 OK\r\n";
        $handler->($cgi);
         
    } else {

	my $q = new CGI; ## create a CGI object
	print "Your IP is ";
	print $q->remote_host(); ## print the user ip address
	print "\n";
	open(INDAT, "/etc/hosts") or die($!);
	open(OUTDAT, ">/etc/hosts.new") or die($!);
	my $line ="";
	while($line=<INDAT>) { 
	  @row =split(' ',$line);
	  my $ip, $name = $row[1], $row[2];
          if ($name eq "myserver.local"){
	    $ip = $q->remote_host();
  	    print OUTDAT "$ip  $name\n"; ## print the user ip address

	  }
	  else {
	         print OUTDAT $line;
	  }
        }
	if ($ip eq "") {
	    $ip = $q->remote_host();
  	    print OUTDAT "$ip  myserver.locale\n"; ## print first line with IP
	}    
	 close(INDAT) or die($!);

	 close(OUTDAT) or die($!);
	 unlink "/etc/hosts.old" ;#or die($!);     
	 rename  "/etc/hosts" , "/etc/hosts.old";# or die($!);
	 rename "/etc/hosts.new", "/etc/hosts";# or die($!); 

    }
}
 
 
} 
 
# start the server on port 8080
my $pid = MyWebServer->new(8080)->background();
print "Use 'kill $pid' to stop server.\n";

