from database import db
from datetime import datetime
from sqlalchemy import Enum

class Variation(db.Model):
    __tablename__ = "product_variations"

    id = db.Column(db.Integer, primary_key=True)

    product_id = db.Column(
        db.Integer,
        db.ForeignKey("products.id", ondelete="CASCADE"),
        nullable=False
    )

    variation_type = db.Column(
        Enum("Color", "Size", name="variation_type_enum"),
        nullable=False
    )

    value = db.Column(db.String(100), nullable=False)
    quantity = db.Column(db.Integer, nullable=False, default=0)

    created_at = db.Column(db.DateTime, default=datetime.utcnow)

    product = db.relationship("Product", back_populates="variations")

    __table_args__ = (
        db.UniqueConstraint(
            "product_id",
            "variation_type",
            "value",
            name="uq_product_variations"
        ),
    )

    def to_dict(self):
        return {
            "id": self.id,
            "product_id": self.product_id,
            "variation_type": self.variation_type,
            "value": self.value,
            "quantity": self.quantity,
            "created_at": self.created_at.isoformat()
        }
