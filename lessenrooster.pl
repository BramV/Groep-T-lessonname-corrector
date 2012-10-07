#!/usr/bin/perl


open FILE , "<", "lessen.txt" or die $!;
@lines = <FILE>;
close FILE;
%lessen;
foreach (@lines) {
	@les = split(':',$_);
	chomp($les[1]);
	$lessen{$les[0]} = $les[1];
}


open FILE, "<" , "VP2.ics" or die $!;
@lines = <FILE>;
close FILE;

open FILE , ">", "VP_aangepast.ics", or die $!;
foreach(@lines){
$line = $_;
$line =~ s/\s+\z//;
	if($line =~ m/^SUMMARY/){
		@summary = split(':', $line);
		if (exists $lessen{$summary[1]}){
			print "Naam gevonden voor $summary[1]\n";
			$line =~ s/.*/SUMMARY: $lessen{$summary[1]}/;
		}else{
			print "Geen naam gevonden voor $summary[1]\n";
		}
	}
	print FILE $line . "\n";
}

close FILE;
