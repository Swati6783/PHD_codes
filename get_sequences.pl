#!/usr/bin/perl 
#===============================================================================
#
#         FILE: get_sequences.pl
#
#        USAGE: ./get_sequences.pl  
#
#  DESCRIPTION: 
#
#      OPTIONS: ---
# REQUIREMENTS: --- List of IDs to fetch sequences and a Fasta sequence file from where to fetch sequences
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Swati Sinha
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 03/03/2014 11:51:36 AM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use Bio::DB::Fasta;
use Bio::SeqIO;
my $file=shift;
open(F,$file);
my @data=<F>;
close(F);
my $out;
my $fasta_file=shift;
my $db = Bio::DB::Fasta->new("$fasta_file", -makeid => \&makeid);
# >sp|Q2VPA6|HELQ_MOUSE Helicase POLQ-like OS=Mus musculus GN=Helq PE=1 SV=2
sub makeid
{
  my $header = shift;
	chomp $header;
	my @tmp=split(/\|/, $header);
	$tmp[1];
}
$out = Bio::SeqIO->new('-file' => ">$file.seq",'-format' => 'Fasta');
foreach (@data)
{
  chomp $_;
  my $seqobj = $db->get_Seq_by_id($_);
  $out->write_seq($seqobj);
}
