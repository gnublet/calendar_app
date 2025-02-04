"""create_oauth2_clients_table

Revision ID: 002
Revises: 001
Create Date: 2025-02-03 04:21:41.895350

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '002'
down_revision: Union[str, None] = '001'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.create_table(
        'oauth2_clients',
        sa.Column('id', sa.Integer(), nullable=False),
        sa.Column('client_id', sa.String(), nullable=False),
        sa.Column('client_secret', sa.String(), nullable=False),
        sa.Column('redirect_uri', sa.String(), nullable=False),
        sa.Column('user_id', sa.Integer(), nullable=False),
        sa.PrimaryKeyConstraint('id'),
        sa.ForeignKeyConstraint(['user_id'], ['users.id'], ondelete='CASCADE')
    )
    
    # Create indexes
    op.create_index(op.f('ix_oauth2_clients_id'), 'oauth2_clients', ['id'], unique=False)
    op.create_index(op.f('ix_oauth2_clients_client_id'), 'oauth2_clients', ['client_id'], unique=True)



def downgrade() -> None:
    # Drop indexes
    op.drop_index(op.f('ix_oauth2_clients_client_id'), table_name='oauth2_clients')
    op.drop_index(op.f('ix_oauth2_clients_id'), table_name='oauth2_clients')
    
    # Drop table
    op.drop_table('oauth2_clients')
