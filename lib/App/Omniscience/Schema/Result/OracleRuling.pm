use utf8;
package App::Omniscience::Schema::Result::OracleRuling;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

App::Omniscience::Schema::Result::OracleRuling

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=item * L<DBIx::Class::EncodedColumn>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "EncodedColumn");

=head1 TABLE: C<oracle_rulings>

=cut

__PACKAGE__->table("oracle_rulings");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'oracle_rulings_id_seq'

=head2 card_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 rank

  data_type: 'smallint'
  is_nullable: 0

=head2 ruling_date

  data_type: 'date'
  is_nullable: 0

=head2 ruling_text

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "oracle_rulings_id_seq",
  },
  "card_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "rank",
  { data_type => "smallint", is_nullable => 0 },
  "ruling_date",
  { data_type => "date", is_nullable => 0 },
  "ruling_text",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<unique__oracle_rulings__card_id_rank>

=over 4

=item * L</card_id>

=item * L</rank>

=back

=cut

__PACKAGE__->add_unique_constraint("unique__oracle_rulings__card_id_rank", ["card_id", "rank"]);

=head1 RELATIONS

=head2 card

Type: belongs_to

Related object: L<App::Omniscience::Schema::Result::Card>

=cut

__PACKAGE__->belongs_to(
  "card",
  "App::Omniscience::Schema::Result::Card",
  { id => "card_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-04-21 19:46:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Fjg/El40BzhcLSb4Kqjm2Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
