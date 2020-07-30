using BigchainDBWebServer.Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace BigchainDBWebServer.DAO
{
	public class ProductPlantingDAO : BaseDAO
	{
		public List<ProductPlantingProcess> GetListProductPlantingProcessesByIdProduct(string IdProduct)
		{
			List<ProductPlantingProcess> lst = Model.ProductPlantingProcesses.Where(x => x.idProduct == IdProduct && x.isDelete == 0).ToList();
			return lst;
		}

		public ResultOfRequest InsertPlanting(ProductPlantingProcess product)
		{
			ProductDetail productDetail = Model.ProductDetails.FirstOrDefault(f => f.idProduct == product.idProduct && f.idUser == product.idUser);
			if (productDetail == null)
				return new ResultOfRequest(false, "Lỗi mã nông sản!");
			if (product.dateBegin < productDetail.dateCreated)
				return new ResultOfRequest(false, "Ngày bắt đầu không được trước " + productDetail.dateCreated.GetValueOrDefault().ToString("dd/MM/yyyy"));
			product.dateEnd = product.dateBegin;
			//if (product.dateEnd > productDetail.dateReview)
			//return new ResultOfRequest(false, "Ngày kết thúc không được sau " + productDetail.dateReview.GetValueOrDefault().ToString("dd/MM/yyyy"));
			product.dateCreated = DateTime.Now;
			product.isDelete = 0;
			product.isUpBD = 0;
			Model.ProductPlantingProcesses.Add(product);
			if (Model.SaveChanges() > 0)
				return new ResultOfRequest(true, "Thành công!");
			return new ResultOfRequest(false, "Lỗi lưu!");
		}

		public ResultOfRequest UpdatePlanting(ProductPlantingProcess product)
		{
			ProductPlantingProcess process = Model.ProductPlantingProcesses.FirstOrDefault(f => f.id == product.id);
			if (process == null)
				return new ResultOfRequest(false, "ID không tồn tại! Kiểm tra lại!");
			ProductDetail productDetail = Model.ProductDetails.FirstOrDefault(f => f.idProduct == product.idProduct && f.idUser == product.idUser);
			if (productDetail == null)
				return new ResultOfRequest(false, "Lỗi mã nông sản!");
			if (product.dateBegin < productDetail.dateCreated)
				return new ResultOfRequest(false, "Ngày bắt đầu không được trước " + productDetail.dateCreated.GetValueOrDefault().ToString("dd/MM/yyyy"));
			if (product.dateEnd > productDetail.dateReview)
				return new ResultOfRequest(false, "Ngày kết thúc không được sau " + productDetail.dateReview.GetValueOrDefault().ToString("dd/MM/yyyy"));
			//process.
			process.details = product.details;
			process.dateBegin = product.dateBegin;
			process.dateEnd = product.dateEnd;
			if (Model.SaveChanges() > 0)
				return new ResultOfRequest(true, "Thành công!");
			return new ResultOfRequest(false, "Lỗi lưu!");
		}

		public ResultOfRequest DeletePlanting(int id)
		{
			ProductPlantingProcess productPlantingProcess = Model.ProductPlantingProcesses.FirstOrDefault(f => f.id == id);
			if (productPlantingProcess == null)
				return new ResultOfRequest(false, "Id không đúng");
			productPlantingProcess.isDelete = 1;
			if (Model.SaveChanges() > 0)
				return new ResultOfRequest(true, "Thành công!");
			return new ResultOfRequest(false, "Lỗi xóa!");
		}

		public ResultOfRequest HasUpBD(int id)
		{
			ProductPlantingProcess productPlantingProcess = Model.ProductPlantingProcesses.FirstOrDefault(f => f.id == id);
			if (productPlantingProcess == null)
				return new ResultOfRequest(false, "Id không đúng");
			if (productPlantingProcess.isDelete == 1)
				return new ResultOfRequest(false, "Đã xóa không thể up BD!");
			productPlantingProcess.isUpBD = 1;
			if (Model.SaveChanges() > 0)
				return new ResultOfRequest(true, "Thành công!");
			return new ResultOfRequest(false, "Lỗi lưu!");
		}
		public List<ColumnSelected> GetListOption()
		{
			return Model.ColumnSelecteds.Where(f => f.idType == 1).OrderBy(f => f.id).ToList();
		}
	}
}